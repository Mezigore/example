import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_order_button/cart_create_order_button_wm.dart';

/// [Component] для <CartCreateOrderButton>
class CartCreateOrderButtonComponent implements Component {
  CartCreateOrderButtonComponent(BuildContext context) {
    parent = Injector.of<AppComponent>(context).component;

    messageController = MaterialMessageController.from(context);
    dialogController = DefaultDialogController.from(context);
    navigator = Navigator.of(context);
    rootNavigator = Navigator.of(context, rootNavigator: true);

    wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        dialogController,
        parent.scInteractor,
      ),
    );
  }

  AppComponent parent;
  MessageController messageController;
  DefaultDialogController dialogController;
  NavigatorState navigator;
  NavigatorState rootNavigator;
  WidgetModelDependencies wmDependencies;
}

CartCreateOrderButtonWidgetModel createCartCreateOrderButtonWidgetModel(
  BuildContext context,
) {
  final component =
      Injector.of<CartCreateOrderButtonComponent>(context).component;

  return CartCreateOrderButtonWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.parent.cartManager,
    component.parent.orderManager,
    component.parent.userManager,
    component.dialogController,
    component.parent.analyticsInteractor,
  );
}
