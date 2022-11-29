import 'package:flutter/material.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/app/app.dart';

/// [WidgetModel] для <ThanksScreen>
class ThanksScreenWidgetModel extends WidgetModel {
  ThanksScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
  ) : super(dependencies);

  final NavigatorState _navigator;

  /// Открыть экран заказов
  final openOrdersAction = Action<void>();

  /// Открыть экран каталога
  final openCatalogAction = Action<void>();

  /// Открыть экран рецептов
  final openRecipesAction = Action<void>();

  /// Открыть экран бонусов
  final openDiscountAction = Action<void>();

  @override
  void onBind() {
    super.onBind();
    bind<void>(openCatalogAction, (_) => _openCatalog());
    bind<void>(openOrdersAction, (_) => _openOrders());
    bind<void>(openRecipesAction, (_) => _openRecipes());
    bind<void>(openDiscountAction, (_) => _openDiscount());
  }

  void _openCatalog() {
    _navigator.popUntil((route) => route.isFirst);
  }

  void _openOrders() {
    _navigator.pushNamedAndRemoveUntil(
      AppRouter.ordersScreen,
      (route) => route.isFirst,
    );
  }

  void _openRecipes() {
    _navigator.pushNamedAndRemoveUntil(
      AppRouter.recipesScreen,
      (route) => route.isFirst,
    );
  }

  void _openDiscount() {
    _navigator.pushNamedAndRemoveUntil(
      AppRouter.discountScreen,
      (route) => route.isFirst,
    );
  }
}
