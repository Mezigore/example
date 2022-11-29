import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/new_orders_tab/new_orders_tab_wm.dart';

/// [Component] для <NewOrdersTab>
class NewOrdersTabComponent implements Component {
  NewOrdersTabComponent(BuildContext context) {
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
  DialogController dialogController;
  NavigatorState navigator;
  NavigatorState rootNavigator;
  WidgetModelDependencies wmDependencies;
}

NewOrdersTabWidgetModel createNewOrdersTabWidgetModel(
  BuildContext context,
) {
  final component = Injector.of<NewOrdersTabComponent>(context).component;

  return NewOrdersTabWidgetModel(
    component.wmDependencies,
    component.parent.orderManager,
  );
}
