import 'package:flutter/material.dart';

/// Роут для экранов создания заказа
/// В случае если экраны будут открываться поверх друг друга будет удобно делать popUntil
class CreateOrderMaterialRoute<T> extends MaterialPageRoute<T> {
  CreateOrderMaterialRoute({
    WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = true,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );
}
