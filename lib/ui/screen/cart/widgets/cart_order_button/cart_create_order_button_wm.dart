import 'dart:async';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
// import 'package:appmetrica_sdk/appmetrica_sdk.dart';
import 'dart:developer';
import 'package:flutter/widgets.dart' hide Action;
import 'package:pedantic/pedantic.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/cart/cart.dart';
import 'package:uzhindoma/interactor/analytics/analytics_interactor.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';
import 'package:uzhindoma/interactor/order/order_manager.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';

/// [WidgetModel] для <CartCreateOrderButton>
class CartCreateOrderButtonWidgetModel extends WidgetModel {
  CartCreateOrderButtonWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._cartManager,
    this._orderManager,
    this._userManager,
    this._dialogController,
    this._analyticsInteractor,
  ) : super(dependencies);

  final NavigatorState _navigator;
  final AnalyticsInteractor _analyticsInteractor;
  final CartManager _cartManager;
  final OrderManager _orderManager;
  final UserManager _userManager;
  final DefaultDialogController _dialogController;

  /// Оформить заказ
  final createOrderAction = Action<void>();

  bool selectRecipeErr = false;

  /// Идет ли загрузка данных для заказа
  final isLoadingData = StreamedState<bool>(false);

  /// Поток с данными корзины
  EntityStreamedState<Cart> get cartState => _cartManager.cartState;

  @override
  void onBind() {
    super.onBind();
    bind<void>(createOrderAction, (_) => createOrder());
  }

  /// true - для другого пользователя
  /// false - для себя
  /// null - отказался делать заказ
  Future<bool> _isForAnotherClient() async {
    final isExists = await _orderManager.isOrderAlreadyExists();
    if (isExists) {
      return _dialogController.showAcceptBottomSheetWithNull(
        createOrderNewOrderTitle,
        subtitle: createOrderNewOrderSubtitle,
        agreeText: createOrderNewOrderAnotherClient,
        cancelText: createOrderNewOrderSelf,
      );
    } else {
      return false;
    }
  }

  Future<void> createOrder() async {
    if (_cartManager.cartState.value.data.promoname != null){
      if(!_cartManager.selectRecipe){
        selectRecipeErr = true;
        await _cartManager.noSelectRecipeErr();
      }else{
        selectRecipeErr = false;
        final isForAnotherClient = await _isForAnotherClient();
        if (isForAnotherClient == null) return;
        unawaited(AppMetrica.reportEvent('checkout_start'));
        _analyticsInteractor.events.trackCheckoutStart();
        _openOrderScreen(!isForAnotherClient);
      }
    }else{
      if (!(_cartManager.cartState.value?.data?.canCreateOrder ?? false)) {
        selectRecipeErr = false;
        _navigator.pop();
      }else {
        if(!_cartManager.selectRecipe){
          selectRecipeErr = true;
          await _cartManager.noSelectRecipeErr();
        }else{
          selectRecipeErr = false;
          final isForAnotherClient = await _isForAnotherClient();
          if (isForAnotherClient == null) return;
          unawaited(AppMetrica.reportEvent('checkout_start'));
          _analyticsInteractor.events.trackCheckoutStart();
          _openOrderScreen(!isForAnotherClient);
        }
      }
    }

  }

  void _openOrderScreen(bool isForSelf) {
    isLoadingData.accept(true);
    doFutureHandleError<void>(
      Future.wait([
        _orderManager.checkPaymentSystem(),
        _orderManager.initOrder(),
        if (isForSelf) _userManager.loadUserInfo(),
        _userManager.loadUserAddresses(),
      ]),
      (futures) {
        isLoadingData.accept(false);
        if (!_userManager.isFullOrderInfo && isForSelf) {
          _navigator.pushNamed(AppRouter.createOrderUserInfo);
          return;
        }
        if (!_userManager.hasAddresses) {
          _navigator.pushNamed(AppRouter.createOrderCreateAddress);
          return;
        }
        _navigator.pushNamed(AppRouter.createOrderSelectAddress,
            arguments: isForSelf);
      },
      onError: (_) => isLoadingData.accept(false),
    );
  }
}
