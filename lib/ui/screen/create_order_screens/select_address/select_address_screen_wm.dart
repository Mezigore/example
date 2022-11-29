// import 'package:appmetrica_sdk/appmetrica_sdk.dart';
import 'dart:async';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:pedantic/pedantic.dart';
import 'package:surf_mwwm/surf_mwwm.dart' as surf_mwwm;
import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/domain/catalog/city_item.dart';
import 'package:uzhindoma/domain/order/order_wrapper.dart';
import 'package:uzhindoma/interactor/analytics/analytics_interactor.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';
import 'package:uzhindoma/interactor/city/city_manager.dart';
import 'package:uzhindoma/interactor/order/order_manager.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_base_wm.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_route.dart';
import 'package:uzhindoma/util/clean_phone_number.dart';
import 'package:uzhindoma/util/const.dart';
import 'package:uzhindoma/util/validate_data.dart';

/// WidgetModel для <SelectAddressScreen>
class SelectAddressScreenWidgetModel extends CreateOrderBaseWidgetModel {
  SelectAddressScreenWidgetModel(
    surf_mwwm.WidgetModelDependencies dependencies,
    NavigatorState navigator,
    OrderDialogController dialogController,
    this._userManager,
    this._orderManager,
    this._cityManager,
    this._cartManager,
    // ignore: avoid_positional_boolean_parameters
    this._isForSelf,
    this._analyticsInteractor,
    this._messageController,
  )   : anotherClientState = surf_mwwm.StreamedState<bool>(!_isForSelf),
        super(
          dependencies,
          navigator,
          dialogController,
        );

  final UserManager _userManager;
  final OrderManager _orderManager;
  final CityManager _cityManager;
  final CartManager _cartManager;
  final AnalyticsInteractor _analyticsInteractor;
  final bool _isForSelf;
  final surf_mwwm.MessageController _messageController;

  /// Ключ формы для другого получателя
  final formKey = GlobalKey<FormState>();

  /// Дальше по оформлению заказа
  final nextAction = surf_mwwm.Action<void>();

  /// Нажатие на адрес - смена адреса
  final addressTapAction = surf_mwwm.Action<void>();

  /// Добавить адресс
  final addAddressAction = surf_mwwm.Action<void>();

  /// Изменение переключателя на другого получателя
  final anotherClientChangeAction = surf_mwwm.Action<bool>();

  final commentTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final phoneController = surf_mwwm.TextEditingAction();

  /// Есть ли другой получатель
  final surf_mwwm.StreamedState<bool> anotherClientState;

  /// Состояние валидности номера телефона
  final phoneValidState = surf_mwwm.StreamedState<String>();

  /// Текущий адрес
  final addressState = surf_mwwm.StreamedState<UserAddress>();

  @override
  void onLoad() {
    super.onLoad();

    subscribe(_cartManager.errorStream, handleError);

    _subscribeToChangeAddress();
    phoneValidState.accept();
    _subscribeToChangeUserAddresses();
  }

  @override
  void onBind() {
    super.onBind();
    bind<void>(addressTapAction, (_) => _openAddressesBottomSheet());
    bind<void>(addAddressAction, (_) => _openAddAddressScreen());
    bind<void>(nextAction, (_) => _checkAddress());
    bind<bool>(
      anotherClientChangeAction,
      (isForAnotherClient) => (_isForSelf ?? true)
          ? anotherClientState.accept(isForAnotherClient)
          : null,
    );
    bind<String>(
      phoneController,
      (phone) => phoneValidState.accept(
        validatePhoneNumber(phone),
      ),
    );
  }

  Future<void> _openAddressesBottomSheet() async {
    final newAddress = await orderDialogController.showAddressPicker(
      _userManager.userAddressesState.value.data,
      addressState.value,
    );
    if (newAddress != null) await addressState.accept(newAddress);
  }

  void _subscribeToChangeAddress() {
    subscribe<UserAddress>(addressState.stream, (address) {
      if (address != null) {
        commentTextController.text = address.comment;
      }
    });
  }

  void _subscribeToChangeUserAddresses() {
    subscribe<surf_mwwm.EntityState<List<UserAddress>>>(
      _userManager.userAddressesState.stream,
      (entity) {
        if ((entity.isLoading ?? true) || (entity.hasError ?? true)) return;
        final defaultAddress = entity?.data?.firstWhere(
          (ad) => ad.isDefault,
          orElse: () => entity?.data?.first,
        );
        if (defaultAddress != null) addressState.accept(defaultAddress);
      },
    );
  }

  Future<void> _openAddAddressScreen() async {
    final newAddress = await navigator.pushNamed<UserAddress>(
      AppRouter.createOrderCreateAddress,
      arguments: true,
    );
    if (newAddress != null) await addressState.accept(newAddress);
  }

  Future<void> _checkAddress() async {
    final addressCity = addressState?.value?.cityId?.toString();
    final currentCityId = _cityManager.currentCity.value?.data?.id;
    if (currentCityId == addressCity) {
      await _openNextScreen();
      return;
    }
    final isDeliveryAvailable =
        await _orderManager.isDeliveryAvailable(addressCity);
    if (isDeliveryAvailable) {
      await _openNextScreen();
      return;
    }
    final needClearCart = await orderDialogController.showAcceptBottomSheet(
      _getBottomSheetTitle(currentCityId),
      agreeText: createOrderClearCart,
      cancelText: createOrderChangeAddress,
    );
    if (needClearCart) {
      _cartManager.clearCart();
      await _cityManager.currentCity.content(
        CityItem(id: currentCityId, name: addressState?.value?.cityName),
      );
      navigator.popUntil((route) => route is! CreateOrderMaterialRoute);
    }
  }

  Future<void> _openNextScreen() async {
    unawaited(AppMetrica.reportEvent('address_added'));
    _analyticsInteractor.events.trackAddressAdded();
    if (anotherClientState?.value ?? false) {
      await phoneValidState.accept(validatePhoneNumber(phoneController.value));
      if (formKey.currentState.validate() && phoneValidState.value == null) {
        final phone = cleanPhoneNumber(phoneController.value);
        final newOrderWrapper =
            (_orderManager.orderWrapperState.value ?? const OrderWrapper())
                .copyWith(
          name: nameTextController.text,
          phone: phone,
          address: addressState.value,
          addressComment: commentTextController.text,
        );
        await _orderManager.orderWrapperState.accept(newOrderWrapper);
      } else {
        _messageController.show(
          msg: errorAddressText,
          msgType: MsgType.commonError,
        );

        return;
      }
    } else {
      final newOrderWrapper =
          (_orderManager.orderWrapperState.value ?? const OrderWrapper())
              .copyWith(
        /// Пустые строки на случай изменения данных
        name: emptyString,
        phone: emptyString,
        address: addressState.value,
        addressComment: commentTextController.text,
      );
      await _orderManager.orderWrapperState.accept(newOrderWrapper);
    }

    await navigator.pushNamed(AppRouter.createOrderSelectDeliveryDate);
  }

  String _getBottomSheetTitle(String cityId) {
    /// Не хочется выносить в кончтанты чтобы не думали, что это норм ситуация
    switch (cityId) {

      /// Москва
      case '84':

      /// Московская область
      case '191':
        return createOrderWrongAddressMoscow;

      /// Питер
      case '85':

      /// Лененградская область
      case '211':
        return createOrderWrongAddressStP;
      default:
        return createOrderWrongAddressDefault;
    }
  }
}
