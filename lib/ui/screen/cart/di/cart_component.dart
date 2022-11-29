import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';
import 'package:uzhindoma/interactor/catalog/menu_manager.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/di/widget_component.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/cart/cart_wm.dart';

/// di for [CartWidgetModel]
class CartComponent extends WidgetComponent {
  CartComponent(BuildContext context) : super(context) {
    final parent = Injector.of<AppComponent>(context).component;
    _navigator = Navigator.of(context);
    _messageController = MaterialMessageController(scaffoldKey);
    _dialogController = DefaultDialogController(scaffoldKey);

    _cartManager = parent.cartManager;
    _menuManager = parent.menuManager;

    _wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        _messageController,
        _dialogController,
        parent.scInteractor,
      ),
    );
  }

  CartManager _cartManager;
  MenuManager _menuManager;
  NavigatorState _navigator;
  MessageController _messageController;
  DefaultDialogController _dialogController;
  WidgetModelDependencies _wmDependencies;
}

/// builder by TemplateWm
CartWidgetModel createCartWm(
  BuildContext context,
  Route cartRoute,
) {
  final component = Injector.of<CartComponent>(context).component;
  return CartWidgetModel(
    component._wmDependencies,
    component._navigator,
    component._cartManager,
    component._dialogController,
    component._menuManager,
    cartRoute,
    component._messageController,
  );
}
