import 'dart:io';

import 'package:dio/dio.dart' as dio_replacer;
import 'package:mad_pay/mad_pay.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/api/data/order/payment_system.dart';
import 'package:uzhindoma/domain/order/bonus.dart';
import 'package:uzhindoma/domain/order/created_order.dart';
import 'package:uzhindoma/domain/order/delivery_date.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/domain/order/order_from_history.dart';
import 'package:uzhindoma/domain/order/order_summ.dart';
import 'package:uzhindoma/domain/order/order_updating.dart';
import 'package:uzhindoma/domain/order/order_wrapper.dart';
import 'package:uzhindoma/domain/order/orders_history_raiting.dart';
import 'package:uzhindoma/domain/order/pay_system.dart';
import 'package:uzhindoma/interactor/analytics/analytics_interactor.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';
import 'package:uzhindoma/interactor/catalog/menu_manager.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/interactor/order/order_exceptions.dart';
import 'package:uzhindoma/interactor/order/order_interactor.dart';
import 'package:uzhindoma/interactor/order/pay_settings.dart';

/// Менеджер для работы с заказом
class OrderManager {
  OrderManager(
    this._orderInteractor,
    this._cartManager,
    this._menuManager,
    this._pay,
    this._analyticsInteractor,
  );

  final OrderInteractor _orderInteractor;
  final CartManager _cartManager;
  final MenuManager _menuManager;
  final AnalyticsInteractor _analyticsInteractor;
  final MadPay _pay;

  /// Поток с данными о заказе
  final orderState = EntityStreamedState<OrderSum>();

  /// Поток на время оформления заказа
  final orderWrapperState = StreamedState<OrderWrapper>();

  /// Поток с данными о прошлых заказах
  /// (добавлен с целью оптимизации - мы забыли пагинацию и
  /// если у пользователя будет грузиться много заказов каждый раз будет
  /// не ок, а так мы обойдемся одной загрузкой)
  final historyState = EntityStreamedState<List<OrderFromHistory>>();

  /// Поток с данными об актуальных заказах
  final actualState = EntityStreamedState<List<NewOrder>>();

  /// Поток с ифнормацией может ли пользователь
  /// использовать системную систему оплаты
  final _canUserPayWithPaymentSystem = StreamedState<bool>();

  bool get isPromo => _cartManager?.cartState?.value?.data?.promoname != null;

  int get _sumId => orderState?.value?.data?.sumId;

  bool get isPaymentEnabled =>
      (_canUserPayWithPaymentSystem.value ?? false) &&
      (_menuManager.currentWeekState.value?.id ==
          _menuManager.weeksInfoState.value?.data?.first?.id);

  bool isPaymentEnableInDay(DateTime day) {
    try {
      if (_menuManager.weeksInfoState.value == null ||
          _menuManager.weeksInfoState.value.data.isEmpty) return false;
      final first = _menuManager.weeksInfoState.value?.data?.first;
      return (day.isAfter(first.startDate) ||
              day.isAtSameMomentAs(first.startDate)) &&
          (day.isBefore(first.endDate) ||
              day.isAtSameMomentAs(first.endDate)) &&
          (_canUserPayWithPaymentSystem.value ?? false);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }

  /// Проверка может ли пользователь использовать нативную систему оплаты
  Future<void> checkPaymentSystem() async {
    final isPaymentEnabled = await _pay.checkPayments();
    await _canUserPayWithPaymentSystem.accept(isPaymentEnabled);
  }

  /// Отправка токена для оплаты заказа
  Future<void> payWithPaymentSystem(String token, String orderId) async {
    final paySystem = PaySystem(
      paymentToken: token,
      paySystem:
          Platform.isIOS ? PaymentSystem.applePay : PaymentSystem.googlePay,
    );
    await _orderInteractor.payWithPaymentSystem(orderId, paySystem);
    return _analyticsInteractor.events.trackPaymentSystemSuccess();
  }

  /// Получение токена для оплаты
  Future<String> getTokenForPaymentSystem(OrderSum sum) async {
    try {
      final response = await _pay.processingPayment(
        google: PaySettings.googleParameters,
        apple: PaySettings.appleParameters,
        currencyCode: 'RUB',
        countryCode: 'RU',
        paymentItems: [
          PaymentItem(
            name: 'Ужин дома',
            price: sum.discountPrice.toDouble(),
          ),
        ],
        paymentNetworks: PaySettings.allowedNetworks,
      );
      return response['token'];
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      if (e is Response && e.errorCode == 'cancelled') {
        throw CancelPaymentException();
      }
      rethrow;
    }
  }

  /// Есть ли у пользователя заказ на выбранную неделю
  Future<bool> isOrderAlreadyExists() async {
    try {
      if (actualState.value?.data == null) {
        await loadActualOrderList();
      }
      final ordersInWeek = actualState.value?.data?.where(
        (order) => order.weekId == _menuManager.currentWeek.id,
      );
      return ordersInWeek.isNotEmpty ?? false;
    } on Exception {
      return false;
    }
  }

  /// Доступна ли доставка в городе
  Future<bool> isDeliveryAvailable(String cityId) async {
    if (_sumId == null) throw OrderNotInitialized();
    final wrap = await _orderInteractor.checkDeliveryAvailableByCityId(cityId);
    return wrap.isAvailable;
  }

  /// Инициализация заказа
  Future<void> initOrder() async {
    await orderState.loading(orderState?.value?.data);
    try {
      final order = await _orderInteractor.initOrder();
      await orderState.content(order);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<OrderSum>.error(
        e,
        orderState?.value?.data,
      );
      await orderState.accept(newState);
      rethrow;
    }
  }

  /// Добавление промокода к заказу
  Future<void> addPromoCode(String promoCode) async {
    if (_sumId == null) throw OrderNotInitialized();
    await orderState.loading(orderState?.value?.data);
    try {
      final order = await _orderInteractor.addPromoCode(
        _sumId.toString(),
        promoCode,
      );
      await orderState.content(order);
      if (order.promoCode == null || order.promoCode == 0) {
        throw WrongPromoCodeException();
      }
    } on Exception catch (e) {
      if (e is WrongPromoCodeException) rethrow;
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<OrderSum>.error(
        e,
        orderState?.value?.data,
      );
      await orderState.accept(newState);
      rethrow;
    }
  }

  /// Удаление промокода из заказа
  Future<void> removePromoCode() async {
    if (_sumId == null) throw OrderNotInitialized();
    await orderState.loading(orderState?.value?.data);
    try {
      final order = await _orderInteractor.removePromoCode(_sumId.toString());
      await orderState.content(order);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<OrderSum>.error(
        e,
        orderState?.value?.data,
      );
      await orderState.accept(newState);
      rethrow;
    }
  }

  /// Получить информацию о возможных бнусах к заказу
  Future<Bonus> getBonus() {
    if (_sumId == null) throw OrderNotInitialized();
    return _orderInteractor.getBonus(_sumId.toString());
  }

  /// Добавление бонусов к заказу
  Future<void> addBonuses() async {
    if (_sumId == null) throw OrderNotInitialized();
    await orderState.loading(orderState?.value?.data);
    try {
      final order = await _orderInteractor.addBonus(_sumId.toString());
      await orderState.content(order);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<OrderSum>.error(
        e,
        orderState?.value?.data,
      );
      await orderState.accept(newState);
      rethrow;
    }
  }

  /// Удаление бонуса из заказа
  Future<void> removeBonuses() async {
    if (_sumId == null) throw OrderNotInitialized();
    await orderState.loading(orderState?.value?.data);
    try {
      final order = await _orderInteractor.removeBonuses(_sumId.toString());
      await orderState.content(order);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<OrderSum>.error(
        e,
        orderState?.value?.data,
      );
      await orderState.accept(newState);
      rethrow;
    }
  }

  /// Получить информацию о возможном времени доставки
  Future<List<DeliveryDate>> getDeliveryDate(String cityId) {
    return _orderInteractor.getDeliveryDateList(cityId);
  }

  /// Получить информацию о возможном времени доставки
  Future<List<DeliveryDate>> getDeliveryDateForOrder(
    String orderId,
    String cityId,
  ) {
    return _orderInteractor.getDeliveryDateListById(orderId, cityId);
  }

  /// Оплатить заказ картой пользователя определенный заказ
  Future<void> payWithCard(String orderId, String cardId) {
    return _orderInteractor.payWithCard(orderId, cardId);
  }

  /// Завершение заказа
  Future<String> completeOrder() async {
    final wrapper = orderWrapperState.value;
    final isNoPaper = _cartManager.noPaperRecipeState.value;
    final order = CreatedOrder.fromOrderWrapper(
      wrapper.copyWith(
        isNoPaperRecipe: isNoPaper[0],
        isPromo: _cartManager.cartState.value.data.promoname != null ? 1 : null,
      ),
    );
    final orderId = await _orderInteractor.createOrder(order);
    _analyticsInteractor.events.trackCheckoutComplete();
    _updateCard();
    return orderId;
  }

  void _updateCard() => _cartManager.updateCart();

  /// Загрузка информации об истории заказов пользователя
  Future<void> loadHistoryOrderList() async {
    // в случае если уже грузимся - не делаем новый запрос
    if (historyState.value?.isLoading ?? false) {
      return;
    }

    await historyState.loading(historyState?.value?.data);
    try {
      final res = await _orderInteractor.getOrderHistoryList();
      await historyState.content(res);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<List<OrderFromHistory>>.error(
        e,
        historyState?.value?.data,
      );
      await historyState.accept(newState);
      rethrow;
    }
  }

  /// Получение информации об актуальных заказов пользователя
  Future<void> loadActualOrderList() async {
    // в случае если уже грузимся - не делаем новый запрос
    if (actualState.value?.isLoading ?? false) {
      return;
    }

    await actualState.loading(actualState?.value?.data);
    try {
      final res = await _orderInteractor.getActualOrderList();
      await actualState.content(res);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<List<NewOrder>>.error(
        e,
        actualState?.value?.data,
      );
      await actualState.accept(newState);
      rethrow;
    }
  }

  /// Отмена заказа
  /// Метод подразумевает прокси интерактора. Список не обновляем чтобы не
  /// зацепить логику между собой и не сделать трудно поддерживаемый узел.
  /// Подразумевается, вызов обновления списка актуальных сразу после.
  Future<String> cancelOrder(String orderId, String reason) async {
    try {
    await _orderInteractor.cancelOrder(orderId, reason);
    } on dio_replacer.DioError catch (e) {
      return e.response.data['userMessage'].toString();
    }
    return 'success';
  }

  /// Восстановление заказа
  /// Метод подразумевает прокси интерактора. Список не обновляем чтобы не
  /// зацепить логику между собой и не сделать трудно поддерживаемый узел.
  /// Подразумевается, вызов обновления списка актуальных сразу после.
  Future<void> restoreOrder(String orderId) {
    return _orderInteractor.restoreOrder(orderId);
  }

  /// Обновление заказа
  /// Метод подразумевает прокси интерактора. Список не обновляем чтобы не
  /// зацепить логику между собой и не сделать трудно поддерживаемый узел.
  /// Подразумевается, вызов обновления списка актуальных сразу после.
  Future<void> editOrder(String orderId, OrderUpdating orderUpdate) {
    return _orderInteractor.editOrder(orderId, orderUpdate);
  }

  /// Оценка заказа
  Future<void> rateOrder(
    String orderId,
    List<OrdersHistoryRating> ordersHistoryRatings,
  ) async {
    await _orderInteractor.rateOrder(orderId, ordersHistoryRatings);

    final currentHistoryList = historyState.value?.data?.toList();

    if (currentHistoryList != null && currentHistoryList.isNotEmpty) {
      final ratedOrderIndex = currentHistoryList.indexWhere(
        (order) => order.id == orderId,
      );

      // а если нет то что мы оценивали вообще???
      if (ratedOrderIndex >= 0) {
        final ratedOrder = currentHistoryList.removeAt(ratedOrderIndex);
        currentHistoryList.insert(
          ratedOrderIndex,
          ratedOrder.rate(ordersHistoryRatings),
        );

        await historyState.content(currentHistoryList);
      }
    }
  }

  /// Количество блюд в корзине
  Future<int> getCountDishes() async =>
      _cartManager.cartState.value.data.menu.length;
}
