import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/domain/order/order_change_enum.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/change_order/change_order_screen_wm.dart';

/// [Component] для <ChangeOrderScreen>
class ChangeOrderScreenComponent implements Component {
  ChangeOrderScreenComponent(BuildContext context) {
    parent = Injector.of<AppComponent>(context).component;

    messageController = MaterialMessageController(scaffoldKey);
    dialogController = OrderDialogController(scaffoldKey);
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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  AppComponent parent;
  MessageController messageController;
  OrderDialogController dialogController;
  NavigatorState navigator;
  NavigatorState rootNavigator;
  WidgetModelDependencies wmDependencies;
}

ChangeOrderScreenWidgetModel createChangeOrderScreenWidgetModel(
  BuildContext context,
  OrderChanges change,
  NewOrder order,
) {
  final component = Injector.of<ChangeOrderScreenComponent>(context).component;

  return ChangeOrderScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.dialogController,
    component.parent.orderManager,
    component.parent.userManager,
    change,
    order,
  );
}
