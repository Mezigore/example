import 'package:uzhindoma/api/data/order/card_id.dart';
import 'package:uzhindoma/api/data/order/promocode.dart';
import 'package:uzhindoma/domain/order/bonus.dart';
import 'package:uzhindoma/domain/order/created_order.dart';
import 'package:uzhindoma/domain/order/delivery_available.dart';
import 'package:uzhindoma/domain/order/delivery_date.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/domain/order/order_from_history.dart';
import 'package:uzhindoma/domain/order/order_summ.dart';
import 'package:uzhindoma/domain/order/order_updating.dart';
import 'package:uzhindoma/domain/order/orders_history_raiting.dart';
import 'package:uzhindoma/domain/order/pay_system.dart';
import 'package:uzhindoma/interactor/order/order_repository/order_mappers.dart';
import 'package:uzhindoma/interactor/order/order_repository/order_repository.dart';
import 'package:uzhindoma/util/future_utils.dart';

/// Интерактор для работы с заказом
class OrderInteractor {
  OrderInteractor(this._repository);

  final OrderRepository _repository;

  /// Создание заказа
  Future<String> createOrder(CreatedOrder order) {
    final orderData = mapCreateOrderData(order);
    return checkMapping(_repository.createOrder(orderData));
  }

  /// Проверка доступности доставки в другом городе
  Future<DeliveryAvailable> checkDeliveryAvailableByCityId(String cityId) {
    return checkMapping(_repository.checkDeliveryAvailableByCityId(cityId));
  }

  /// Получить количество бонусов, которые можно списать для заказа
  Future<Bonus> getBonus(String sumId) {
    return checkMapping(_repository.getBonus(sumId));
  }

  /// Удалить бонусы
  Future<OrderSum> removeBonuses(String sumId) {
    return checkMapping(_repository.removeBonuses(sumId));
  }

  /// Добавить бонусы к заказу
  Future<OrderSum> addBonus(String sumId) {
    return checkMapping(_repository.addBonus(sumId));
  }

  /// Оплатить заказ картой
  Future<void> payWithCard(String orderId, String cardId) {
    final cardIdData = CardIdData(cardId: cardId);
    return checkMapping(_repository.payWithCard(orderId, cardIdData));
  }

  /// Удалить промокод из заказа
  Future<OrderSum> removePromoCode(String sumId) {
    return checkMapping(_repository.removePromoCode(sumId));
  }

  /// Добавить промокод к заказу
  Future<OrderSum> addPromoCode(String sumId, String promoCode) {
    final promoCodeData = PromoCodeData(promoCode: promoCode);
    return checkMapping(_repository.addPromoCode(sumId, promoCodeData));
  }

  /// Инициализировать заказ
  Future<OrderSum> initOrder() {
    return checkMapping(_repository.initOrder());
  }

  /// Получить даты и время доставки
  Future<List<DeliveryDate>> getDeliveryDateList(String cityId) {
    return checkMapping(_repository.getDeliveryDateList(cityId));
  }

  /// Получение информации об истории заказов пользователя
  Future<List<OrderFromHistory>> getOrderHistoryList() async {
    final orders = await checkMapping(_repository.getOrderHistoryList());
    return orders
      ..sort(
        (first, second) => second.orderDate.compareTo(first.orderDate),
      );
  }

  /// Получение информации о новых заказах
  Future<List<NewOrder>> getActualOrderList() async {
    final orders = await checkMapping(_repository.getActualOrderList());
    return orders
      ..sort(
        (first, second) => second.orderDate.compareTo(first.orderDate),
      );
  }

  /// Получение времени и даты доставки для конкретного заказа
  Future<List<DeliveryDate>> getDeliveryDateListById(String id, String city) {
    return checkMapping(_repository.getDeliveryDateListById(id, city));
  }

  /// Оценка блюд из заказа
  Future<void> rateOrder(
    String id,
    List<OrdersHistoryRating> ordersHistoryRatings,
  ) {
    return checkMapping(_repository.rateOrder(id, ordersHistoryRatings));
  }

  /// Восстановление заказа
  Future<void> restoreOrder(String id) {
    return checkMapping(_repository.restoreOrder(id));
  }

  /// Отмена заказа
  Future<void> cancelOrder(String id, String reason) {
    return checkMapping(_repository.cancelOrder(id, reason));
  }

  /// Изменение заказа
  Future<void> editOrder(String id, OrderUpdating orderUpdating) {
    return checkMapping(_repository.editOrder(id, orderUpdating));
  }

  /// Оплата через нативную систему оплаты
  Future<void> payWithPaymentSystem(String orderId, PaySystem paySystem) {
    return checkMapping(
      _repository.payOrderWithPaymentSystem(orderId, paySystem),
    );
  }
}
