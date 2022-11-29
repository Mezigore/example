import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_no_paper/cart_no_paper_wm.dart';

/// Компонент для блока с отказом от печатных рецептов в CartScreen
/// [Component] для <CartNoPaper>
class CartNoPaperComponent implements Component {
  CartNoPaperComponent(BuildContext context) {
    parent = Injector.of<AppComponent>(context).component;

    messageController = MaterialMessageController.from(context);
    dialogController = DefaultDialogController.from(context);
    navigator = Navigator.of(context);
    rootNavigator = Navigator.of(context, rootNavigator: true);

    wmDependencies = const WidgetModelDependencies();
  }

  AppComponent parent;
  MessageController messageController;
  DefaultDialogController dialogController;
  NavigatorState navigator;
  NavigatorState rootNavigator;
  WidgetModelDependencies wmDependencies;
}

CartNoPaperWidgetModel createCartNoPaperWidgetModel(
  BuildContext context,
  bool bottomSheet,
) {
  final component = Injector.of<CartNoPaperComponent>(context).component;

  return CartNoPaperWidgetModel(
    component.wmDependencies,
    component.parent.cartManager,
    bottomSheet,
  );
}
