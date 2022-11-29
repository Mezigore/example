import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uzhindoma/interactor/auth/auth_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/res/strings/business_string.dart';
import 'package:uzhindoma/ui/screen/main/widget/drawer/main_drawer_widget.dart';

/// [WidgetModel] for [MainDrawerWidget]
class MainDrawerWidgetModel extends WidgetModel {
  MainDrawerWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._authManager,
  ) : super(dependencies);

  final NavigatorState navigator;
  final AuthManager _authManager;

  /// Перейти в корзину
  final ordersAction = Action<void>();

  /// Перейти в рецепты
  final recipesAction = Action<void>();

  /// Перейти в Получить 500 бонусов
  final discountAction = Action<void>();

  /// Перейти в профайл
  final profileAction = Action<void>();

  /// Перейти в 'О сервисе'
  final aboutServiceAction = Action<void>();

  /// деавторизироваться
  final logoutAction = Action<void>();

  /// Позвонить в офис
  final callToAction = Action<void>();

  @override
  void onBind() {
    super.onBind();
    subscribe<void>(
      ordersAction.stream,
      (_) => _openScreen(AppRouter.ordersScreen),
    );
    subscribe<void>(discountAction.stream, (_) {
      AppMetrica.reportEvent('bonus_view');
      _authManager.reportEventOpenDiscountScreen();
      _openScreen(AppRouter.discountScreen);
    });
    subscribe<void>(
      profileAction.stream,
      (_) => _openScreen(AppRouter.profile),
    );
    subscribe<void>(
      recipesAction.stream,
      (_) {
        AppMetrica.reportEvent('recipes_open');
        _openScreen(AppRouter.recipesScreen);
      },
    );

    subscribe<void>(
      aboutServiceAction.stream,
      (_) => _openScreen(AppRouter.aboutScreen),
    );
    subscribe<void>(logoutAction.stream, (_) async {
      await _logout();
    });
    subscribe<void>(callToAction.stream, (_) => _callTo());
  }

  /// Открыть экран
  void _openScreen(String routeName) {
    navigator.popAndPushNamed(routeName);
  }

  Future<void> _callTo() async {
    await launch(phone);
  }

  Future<void> _logout() => _authManager.logout();
}
