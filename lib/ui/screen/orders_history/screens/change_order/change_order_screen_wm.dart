import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/domain/order/delivery_date.dart';
import 'package:uzhindoma/domain/order/delivery_time_interval.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/domain/order/order_change_enum.dart';
import 'package:uzhindoma/domain/order/order_updating.dart';
import 'package:uzhindoma/domain/order/payment_type.dart';
import 'package:uzhindoma/domain/payment/payment_card.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/interactor/common/urls.dart';
import 'package:uzhindoma/interactor/order/order_manager.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';

//ignore_for_file: prefer_mixin

/// [WidgetModel] для <ChangeOrderScreen>
class ChangeOrderScreenWidgetModel extends WidgetModel
    with WidgetsBindingObserver {
  ChangeOrderScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._dialogController,
    this._orderManager,
    this._userManager,
    this.change,
    this.order,
  )   : addressState = StreamedState(order.deliveryAddress),
        paymentMethodState = StreamedState<PaymentType>(order.paymentType),
        super(dependencies);

  /// Изменения
  final OrderChanges change;

  /// Заказ
  final NewOrder order;

  final NavigatorState _navigator;
  final OrderDialogController _dialogController;
  final OrderManager _orderManager;
  final UserManager _userManager;

  /// Есть ли клавиатура на экране
  final keyBoardOnScreenState = StreamedState<bool>(false);

  /// Идет ли загрузка
  final isLoadingState = StreamedState<bool>(false);

  /// текущий адрес
  final StreamedState<UserAddress> addressState;
  final commentTextController = TextEditingController();
  final addressTapAction = Action<void>();
  final addAddressAction = Action<void>();

  /// дата и время
  final dateState = EntityStreamedState<List<DeliveryDate>>();
  final selectedDeliveryDateState = StreamedState<DeliveryDate>();
  final selectedIntervalState = StreamedState<DeliveryTimeInterval>();
  final selectDateAction = Action<DeliveryDate>();
  final selectIntervalAction = Action<DeliveryTimeInterval>();
  final reloadDatesAction = Action<void>();

  /// Оплата
  final StreamedState<PaymentType> paymentMethodState;
  final paymentCardState = StreamedState<PaymentCard>();

  EntityStreamedState<List<PaymentCard>> get cardsState =>
      _userManager.userCardsState;
  final selectPaymentMethodAction = Action<void>();
  final selectPaymentCardAction = Action<void>();
  final addPaymentCardAction = Action<void>();

  final saveAction = Action<void>();

  @override
  void onLoad() {
    super.onLoad();
    _subscribeToChangeAddress();
    if (change == OrderChanges.changePaymentType) _subscribeToLoadCard();
    if (change == OrderChanges.changeDeliveryDate) _initDate();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void onBind() {
    super.onBind();

    ///Адрес
    bind<void>(addressTapAction, (_) => _openAddressesBottomSheet());
    bind<void>(addAddressAction, (_) => _openAddAddressScreen());

    /// Дата и время
    bind(selectDateAction, selectedDeliveryDateState.accept);
    bind(selectIntervalAction, selectedIntervalState.accept);
    bind<void>(reloadDatesAction, (_) => _loadDate());

    /// Оплата
    bind<void>(addPaymentCardAction, (_) => _addPaymentCardAction());
    bind<void>(selectPaymentCardAction, (_) => _showSelectCardSheet());
    bind<void>(
      selectPaymentMethodAction,
      (_) => _showSelectPaymentMethodSheet(),
    );

    bind<void>(saveAction, (_) => _onSave());
  }

  @override
  void didChangeMetrics() {
    keyBoardOnScreenState.accept(
      WidgetsBinding.instance.window.viewInsets.bottom > 0,
    );
  }

  Future<void> _openAddressesBottomSheet() async {
    if (_userManager.userAddressesState?.value?.data == null ||
        (_userManager.userAddressesState?.value?.hasError ?? true)) {
      await isLoadingState.accept(true);
      doFutureHandleError<void>(
        _userManager.loadUserAddresses(),
        (_) async {
          await isLoadingState.accept(false);
          final newAddress = await _dialogController.showAddressPicker(
            _userManager.userAddressesState.value.data,
            addressState.value,
          );
          if (newAddress != null) await addressState.accept(newAddress);
        },
        onError: (_) {
          isLoadingState.accept(false);
        },
      );
    } else {
      final newAddress = await _dialogController.showAddressPicker(
        _userManager.userAddressesState.value.data,
        addressState.value,
      );
      if (newAddress != null) await addressState.accept(newAddress);
    }
  }

  void _subscribeToChangeAddress() {
    subscribe<UserAddress>(
      addressState.stream,
      (address) {
        if (address != null) {
          commentTextController.text = address.comment;
        }
      },
    );
  }

  void _openAddAddressScreen() {
    _navigator.pushNamed(AppRouter.addAddressScreen);
  }

  void _loadDate() {
    /// Что делаем? не верим в эту ситуацию?
    if (order.deliveryAddress.cityId == null) return;
    isLoadingState.accept(true);
    doFutureHandleError<List<DeliveryDate>>(
      _orderManager.getDeliveryDateForOrder(
        order.id,
        order.deliveryAddress.cityId.toString(),
      ),
      (dates) {
        dateState.content(dates);
        isLoadingState.accept(false);
      },
      onError: (e) {
        dateState.error(e);
        isLoadingState.accept(false);
      },
    );
  }

  void _initDate() {
    subscribe<DeliveryDate>(selectedDeliveryDateState.stream, (date) {
      if (date == null || date.time == null || date.time.isEmpty) {
        /// Очищаем для упрощения проверки
        selectedIntervalState.accept();
        return;
      }
      selectedIntervalState.accept(date.time.first);
    });

    subscribe<EntityState<List<DeliveryDate>>>(dateState.stream, (entity) {
      if ((entity.isLoading ?? true) || (entity.hasError ?? true)) return;
      selectedDeliveryDateState.accept(entity.data.first);
    });

    _loadDate();
  }

  void _loadCards() {
    doFutureHandleError<void>(
      _userManager.loadUserCards(),
      (_) {
        paymentCardState.accept(cardsState.value?.data?.first);
      },
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

  Future<void> _showSelectCardSheet() async {
    final newCard = await _dialogController.showPaymentCardPicker(
      cardsState?.value?.data,
      currentCard: paymentCardState.value,
    );
    if (newCard == null) return;
    await paymentCardState.accept(newCard);
  }

  Future<void> _showSelectPaymentMethodSheet() async {
    final method = await _dialogController.showPaymentMethodPicker([
      // if (_orderManager.isPaymentEnableInDay(order.orderDate)) PaymentType.pay,
      PaymentType.card,
      PaymentType.cash,
    ]);
    if (method != null) await paymentMethodState.accept(method);
  }

  Future<void> _addPaymentCardAction() async {
    if (_userManager.id == null) return;
    final isAdded = await _navigator.pushNamed<bool>(
      AppRouter.webViewScreen,
      arguments: PaymentUrls.addCardToUser(_userManager.id),
    );
    if (isAdded) _loadCards();
  }

  void _onSave() {
    switch (change) {
      case OrderChanges.changeDeliveryDate:
        _updateDate();
        break;
      case OrderChanges.changeAddress:
        _updateAddress();
        break;
      case OrderChanges.changePaymentType:
        _updatePayment();
        break;
      default:
        throw EnumArgumentException('Not found OrderChanges for $change');
    }
  }

  Future<void> _payOrder() async {
    if (paymentMethodState.value == PaymentType.card) {
      final card = paymentCardState.value;
      if (card == null) {
        await _navigator.pushNamed(
          AppRouter.webViewScreen,
          arguments: PaymentUrls.payOrder(order.id),
        );
        _navigator.pop(true);
      } else {
        doFuture<void>(
          _orderManager.payWithCard(order.id, card.id),
          (_) => _navigator.pop(true),
          onError: (_) => _navigator.pop(true),
        );
      }
    }

    // if (paymentMethodState.value == PaymentType.pay) {
    //   doFuture<void>(
    //     _payWithPaymentSystem(),
    //     (_) => _navigator.pop(true),
    //     onError: (error) {
    //       if (error is! CancelPaymentException) {
    //         _navigator.pop(true);
    //       }
    //     },
    //   );
    // }
  }

  Future<void> _payWithPaymentSystem() async {
    final token = await _orderManager.getTokenForPaymentSystem(order.orderSumm);
    await _orderManager.payWithPaymentSystem(token, order.id);
  }

  void _updatePayment() {
    if (order.paymentType == paymentMethodState.value) {
      _payOrder();
    } else {
      doFutureHandleError<void>(
        _orderManager.editOrder(
          order.id,
          OrderUpdating(paymentType: paymentMethodState.value),
        ),
        (_) {
          if (paymentMethodState.value == PaymentType.cash) {
            _navigator.pop(true);
          } else {
            _payOrder();
          }
        },
      );
    }
  }

  Future<void> _updateAddress() async {
    doFutureHandleError<void>(
      _orderManager.editOrder(
        order.id,
        OrderUpdating(
          addressId: addressState.value.id,
          addressComment: commentTextController.text,
        ),
      ),
      (_) => _navigator.pop(true),
    );
  }

  void _updateDate() {
    if (selectedDeliveryDateState.value == null ||
        selectedIntervalState.value == null) {
      handleError(MessagedException(createOrderNeedToSelectDate));
      return;
    }
    doFutureHandleError<void>(
      _orderManager.editOrder(
        order.id,
        OrderUpdating(
          date: selectedDeliveryDateState.value.date,
          time: selectedIntervalState.value.id,
        ),
      ),
      (_) => _navigator.pop(true),
    );
  }
}
