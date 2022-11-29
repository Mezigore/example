import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/domain/cart/cart_element.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/common/widgets/menu_item_button/menu_item_button_widget.dart';

import '../menu_for_you_item_button_wm.dart';

/// di for [MenuItemButtonWidget]
class MenuForYouItemButtonComponent implements Component {
  MenuForYouItemButtonComponent(BuildContext context) {
    parent = Injector.of<AppComponent>(context).component;
    messageController = MaterialMessageController.from(context);
    dialogController = DefaultDialogController.from(context);

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
  WidgetModelDependencies wmDependencies;
}

MenuForYouItemButtonWidgetModel createMenuForYouItemButtonWidgetModel(
    BuildContext context,
    List<CartElement> cartElements,
    CategoryItem categoryItem,{
      bool needAccentColor,
      bool needDeleteDialog,
    }) {
  final component = Injector.of<MenuForYouItemButtonComponent>(context).component;

  return MenuForYouItemButtonWidgetModel(
    component.wmDependencies,
    component.dialogController,
    cartElements: cartElements,
    cartManager: component.parent.cartManager,
    categoryItem: categoryItem,
    needAccentColor: needAccentColor,
    needDeleteDialog: needDeleteDialog,
  );
}
