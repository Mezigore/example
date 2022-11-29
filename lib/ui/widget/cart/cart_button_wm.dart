// import 'package:appmetrica_sdk/appmetrica_sdk.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/cart/cart.dart';
import 'package:uzhindoma/interactor/analytics/analytics_interactor.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';

/// [WidgetModel] для <CartButton>
class CartButtonWidgetModel extends WidgetModel {
  CartButtonWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._cartManager,
    this._analyticsInteractor,
  ) : super(dependencies);

  // TODO: навигатор нужен для перехода, пока что не используется
  // ignore: unused_field
  final NavigatorState _navigator;
  final CartManager _cartManager;
  final AnalyticsInteractor _analyticsInteractor;

  final openCartAction = Action<void>();

  EntityStreamedState<Cart> get cartState => _cartManager.cartState;

  @override
  void onBind() {
    super.onBind();
    bind<void>(openCartAction, (_) => _openCart());
  }

  void _openCart() {
    _analyticsInteractor.events.trackOpenCartScreen();
    AppMetrica.reportEvent('open_cart');
    _navigator.pushNamed(AppRouter.cartScreen);
  }
}
