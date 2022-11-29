// import 'package:appmetrica_sdk/appmetrica_sdk.dart';
import 'dart:async';
import 'dart:developer';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:pedantic/pedantic.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/order/bonus.dart';
import 'package:uzhindoma/domain/order/order_summ.dart';
import 'package:uzhindoma/domain/order/order_wrapper.dart';
import 'package:uzhindoma/domain/order/payment_type.dart';
import 'package:uzhindoma/domain/order/promocode.dart';
import 'package:uzhindoma/domain/payment/payment_card.dart';
import 'package:uzhindoma/interactor/catalog/menu_manager.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/interactor/common/urls.dart';
import 'package:uzhindoma/interactor/order/order_manager.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_base_wm.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_route.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/select_payment_screen.dart';

import '../../../../domain/core.dart';

// ignore_for_file: prefer_mixin

/// [WidgetModel] для <SelectPaymentScreen>
class SelectPaymentScreenWidgetModel extends CreateOrderBaseWidgetModel
    with WidgetsBindingObserver {
  SelectPaymentScreenWidgetModel(
    WidgetModelDependencies dependencies,
    NavigatorState navigator,
    OrderDialogController dialogController,
    this._orderManager,
    this._userManager,
    this._menuManager,
    this._messageController,
  )   : paymentMethodState = StreamedState<PaymentType>(
          // (_orderManager.isPaymentEnabled ?? false)
          //     ? PaymentType.pay
          //     :
          PaymentType.card,
        ),
        super(
          dependencies,
          navigator,
          dialogController,
        );

  final OrderManager _orderManager;
  final UserManager _userManager;
  final MenuManager _menuManager;
  final MessageController _messageController;

  /// В бета версии по умолчанию карта, потом будет Google/Apple Pay
  final StreamedState<PaymentType> paymentMethodState;
  final paymentCardState = StreamedState<PaymentCard>();
  final isEnablePromoCodeState = StreamedState<bool>(false);
  final promoCodeState =
      StreamedState<PromoCodeState>(PromoCodeState.cannotBeApplied);
  final isEnableBonusState = StreamedState<bool>(false);

  final promoCodeController = TextEditingController();
  final promoCodeFocusNode = FocusNode();

  final isCreatingOrder = StreamedState<bool>(false);

  /// Состояние стоимости
  EntityStreamedState<OrderSum> get sumState => _orderManager.orderState;

  /// Состояние карточек оплаты
  EntityStreamedState<List<PaymentCard>> get cardsState =>
      _userManager.userCardsState;

  /// Сколько бонусов можно списать
  final bonusesState = EntityStreamedState<int>();

  /// Состояние клавиатуры
  final keyBoardOnScreenState = StreamedState<bool>(false);

  /// Количество блюд в корзине
  final countDishes = StreamedState<int>();

  /// Выбор способа оплаты
  final selectPaymentMethodAction = Action<void>();

  /// Выбор карты для оплаты
  final selectPaymentCardAction = Action<void>();

  /// Добавление карты для оплаты
  final addPaymentCardAction = Action<void>();

  /// Добавить промокод к заказу
  final applyPromoCodeAction = Action<void>();

  /// Нажатие на кнопку далее
  final nextAction = Action<void>();

  /// Изменить необходимость промокода в заказе
  final changePromoCodeEnabledAction = Action<bool>();

  /// Изменить необходимость бонусов в заказе
  final changeBonusEnabledAction = Action<bool>();

  /// Промо-набор
  bool get isPromo => _orderManager.isPromo;

  ///Количество заказов пользователя
  int ordersCount = 0;

  @override
  void onLoad() {
    super.onLoad();
    _loadBonuses();
    _subscribeToLoadCard();
    promoCodeController.addListener(_promoCodeListener);
    WidgetsBinding.instance.addObserver(this);
    _getOrdersCount();
    _getCountDishes();
  }

  @override
  void dispose() {
    promoCodeController
      ..removeListener(_promoCodeListener)
      ..dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    keyBoardOnScreenState.accept(
      WidgetsBinding.instance.window.viewInsets.bottom > 0,
    );
  }

  @override
  void onBind() {
    super.onBind();
    bind(changePromoCodeEnabledAction, _showPromoCodeField);
    bind(changeBonusEnabledAction, _changeBonuses);
    bind<void>(nextAction, (_) => _finishOrder());
    bind<void>(applyPromoCodeAction, (_) => _applyPromoCode());
    bind<void>(selectPaymentCardAction, (_) => _selectCardSheet());
    bind<void>(addPaymentCardAction, (_) => _addPaymentCardAction());
    bind<void>(
      selectPaymentMethodAction,
      (_) => _showSelectPaymentMethodSheet(),
    );
  }

  void _promoCodeListener() {
    if (promoCodeController.text == null || promoCodeController.text.isEmpty) {
      if (promoCodeState.value != PromoCodeState.cannotBeApplied) {
        promoCodeState.accept(PromoCodeState.cannotBeApplied);
      }
    } else {
      if (promoCodeState.value != PromoCodeState.canBeApplied) {
        promoCodeState.accept(PromoCodeState.canBeApplied);
      }
    }
  }

  Future<void> _showSelectPaymentMethodSheet() async {
    final method = await orderDialogController.showPaymentMethodPicker([
      // if (_orderManager.isPaymentEnabled ?? false) PaymentType.pay,
      PaymentType.card,
      if (_orderManager.orderWrapperState.value.name == '') PaymentType.cash,
    ]);
    if (method != null) await paymentMethodState.accept(method);
  }

  void _loadBonuses() {
    doFuture<Bonus>(
      _orderManager.getBonus(),
      (bonus) => bonusesState.content(bonus.bonusAmount),
      onError: bonusesState.error,
    );
  }

  void _subscribeToLoadCard() {
    subscribe<PaymentType>(
      paymentMethodState.stream,
      (method) {
        if (method == PaymentType.card) {
          if (cardsState.value?.data == null) {
            _loadCards();
          } else {
            paymentCardState.accept(cardsState.value?.data?.first);
          }
        }
      },
    );
  }

  void _loadCards() {
    doFutureHandleError<void>(
      _userManager.loadUserCards(),
      (_) {
        paymentCardState.accept(cardsState.value?.data?.first);
      },
    );
  }

  void _changeBonuses(bool needAddBonuses) {
    bonusesState.loading(bonusesState.value.data);
    isEnableBonusState.accept(needAddBonuses);
    if (isEnablePromoCodeState.value ?? false) {
      isEnablePromoCodeState.accept(false);
    }
    doFutureHandleError<void>(
      needAddBonuses
          ? _orderManager.addBonuses()
          : _orderManager.removeBonuses(),
      (_) {
        bonusesState.content(bonusesState.value.data);
      },
      onError: (e) {
        isEnableBonusState.accept(!needAddBonuses);
        bonusesState.content(bonusesState.value.data);
      },
    );
  }

  void _applyPromoCode() {
    final promoCode = promoCodeController.text;
    promoCodeFocusNode.unfocus();
    if (promoCode == null || promoCode.isEmpty) return;
    promoCodeState.accept(PromoCodeState.loading);
    doFuture<void>(
      _orderManager.addPromoCode(promoCode),
      (_) {
        if (isEnableBonusState.value ?? false) {
          isEnableBonusState.accept(false);
        }
        return promoCodeState.accept(PromoCodeState.applied);
      },
      onError: (error) {
        if (error is! WrongPromoCodeException) {
          promoCodeState.accept(PromoCodeState.canBeApplied);
          handleError(error);
        } else {
          promoCodeState.accept(PromoCodeState.error);
        }
      },
    );
  }

  void _showPromoCodeField(bool needToShowField) {
    isEnablePromoCodeState.accept(needToShowField);
    if (needToShowField) promoCodeFocusNode.requestFocus();
    if (!needToShowField && promoCodeState.value == PromoCodeState.applied) {
      final prevState = promoCodeState.value;
      promoCodeState.accept(PromoCodeState.loading);
      doFutureHandleError<void>(
        _orderManager.removePromoCode(),
        (_) {
          promoCodeState.accept(PromoCodeState.cannotBeApplied);
        },
        onError: (_) {
          promoCodeState.accept(prevState);
          isEnablePromoCodeState.accept(!needToShowField);
        },
      );
    }
  }

  Future<void> _addPaymentCardAction() async {
    if (_userManager.id == null) return;
    final isAdded = await navigator.pushNamed<bool>(
      AppRouter.webViewScreen,
      arguments: PaymentUrls.addCardToUser(_userManager.id),
    );
    if (isAdded ?? false) _loadCards();
  }

  Future<void> _finishOrder() async {
    await isCreatingOrder.accept(true);
    _applyBonusAndPromoCode();
    unawaited(AppMetrica.reportEvent('payment_clicked'));
    if (paymentMethodState.value == PaymentType.cash) {
      final oldWrapper =
          _orderManager.orderWrapperState.value ?? const OrderWrapper();
      await _orderManager.orderWrapperState.accept(
        oldWrapper.copyWith(
          paymentMethod: PaymentType.cash,
        ),
      );
      _completePayment();
    }
    if (paymentMethodState.value == PaymentType.card) {
      final isCurrentWeek = _menuManager.currentWeek.id ==
          _menuManager.weeksInfoState?.value?.data?.first?.id;
      if (!isCurrentWeek) {
        final isCardSelected = paymentCardState?.value != null;
        if (!isCardSelected) {
          _messageController.show(
            msgType: MsgType.common,
            msg: selectPaymentsNoCard,
          );
          await isCreatingOrder.accept(false);
          return;
        }
      }
      final oldWrapper =
          _orderManager.orderWrapperState.value ?? const OrderWrapper();
      await _orderManager.orderWrapperState.accept(
        oldWrapper.copyWith(
          paymentMethod: PaymentType.card,
        ),
      );
      final card = paymentCardState.value;
      if (card == null) {
        doFutureHandleError<String>(
          _orderManager.completeOrder(),
          (orderId) async {
            final isSuccess = await navigator.pushNamed<bool>(
              AppRouter.webViewScreen,
              arguments: PaymentUrls.payOrder(orderId),
            );
            await isCreatingOrder.accept(false);
            _openTYP(isSuccess ?? false);
          },
          onError: (_) => isCreatingOrder.accept(false),
        );
      } else {
        await _orderManager.orderWrapperState.accept(
          oldWrapper.copyWith(
            card: card,
            paymentMethod: PaymentType.card,
          ),
        );
        doFutureHandleError<String>(
          _orderManager.completeOrder(),
          (id) async {
            _payWithCard(card, id);
          },
        );
      }
    }
  }

  Future<void> _completeOrderForPaymentSystem() async {
    final sum = _orderManager.orderState.value.data;
    final token = await _orderManager.getTokenForPaymentSystem(sum);
    final orderId = await _orderManager.completeOrder();
    try {
      await _orderManager.payWithPaymentSystem(token, orderId);
      _openTYP(true);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      _openTYP(false);
    }
  }

  void _applyBonusAndPromoCode() {
    final oldWrapper =
        _orderManager.orderWrapperState.value ?? const OrderWrapper();
    final bonus = isEnableBonusState.value && bonusesState.value?.data != null
        ? Bonus(bonusAmount: bonusesState.value.data)
        : null;
    final promoCode = isEnablePromoCodeState.value &&
            promoCodeState.value == PromoCodeState.applied
        ? PromoCode(promoCode: promoCodeController.text)
        : null;
    _orderManager.orderWrapperState.accept(
      oldWrapper.copyWith(
        bonus: bonus,
        promoCode: promoCode,
      ),
    );
  }

  void _completePayment({bool isPayed = false}) {
    doFutureHandleError<String>(
      _orderManager.completeOrder(),
      (_) {
        _openTYP(isPayed);
        isCreatingOrder.accept(false);
      },
      onError: (_) => isCreatingOrder.accept(false),
    );
  }

  Future<void> _getOrdersCount()async{
    ///Получение количества заказов, для отображения виджетов на ThanksScreen
    ordersCount = await _userManager.getOrdersCount();
  }

  void _openTYP(bool isPayed){
    doFuture<void>(
      _orderManager.loadActualOrderList(),
      (_) {
        //DO NOTHING
      },
    );
    unawaited(AppMetrica.reportEventWithMap(
        'payment_complete', <String, bool>{'isPayed': isPayed}));
     navigator.pushNamedAndRemoveUntil(
      AppRouter.createOrderTYP,
      (route) => route is! CreateOrderMaterialRoute,
      arguments: Pair(isPayed, ordersCount),
    );
  }

  void _payWithCard(PaymentCard card, String orderId) {
    doFuture<void>(
      _orderManager.payWithCard(orderId, card.id),
      (_) {
        isCreatingOrder.accept(false);
        _openTYP(true);
      },
      onError: (_) {
        isCreatingOrder.accept(false);
        _openTYP(false);
      },
    );
  }

  Future<void> _selectCardSheet() async {
    final newCard = await orderDialogController.showPaymentCardPicker(
      cardsState?.value?.data,
      currentCard: paymentCardState.value,
    );
    if (newCard == null) return;
    await paymentCardState.accept(newCard);
  }

  /// Количество блюд в корзине
  Future<void> _getCountDishes() async {
    await countDishes.accept(await _orderManager.getCountDishes());
  }
}
