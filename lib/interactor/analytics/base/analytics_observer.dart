import 'package:flutter/widgets.dart';
import 'package:uzhindoma/ui/screen/main/main_screen_route.dart';

/// Сбор аналитики по переходам
class AnalyticsNavigationObserver extends RouteObserver<PageRoute<dynamic>> {
  static VoidCallback onOpenCatalog;

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is MainScreenRoute) onOpenCatalog?.call();
  }

  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    if (route is MainScreenRoute) onOpenCatalog?.call();
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is MainScreenRoute) onOpenCatalog?.call();
  }
}
