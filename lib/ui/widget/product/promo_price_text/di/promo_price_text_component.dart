import 'package:flutter/material.dart' hide MenuItem;
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/widget/product/promo_price_text/promo_price_text_wm.dart';

/// di for [PromoPriceTextWidgetModel]
class PromoPriceTextComponent implements Component {
  PromoPriceTextComponent(BuildContext context) {
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

PromoPriceTextWidgetModel createPromoPriceTextWidgetModel(
  BuildContext context,
  MenuItem menuItem,
) {
  final component = Injector.of<PromoPriceTextComponent>(context).component;

  return PromoPriceTextWidgetModel(
    component.wmDependencies,
    menuItem: menuItem,
    cartManager: component.parent.cartManager,
  );
}
