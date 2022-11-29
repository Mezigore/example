import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/new_orders_tab/widgets/order_card/order_card_widget_wm.dart';

/// [Component] для <OrderCardWidget>
class OrderCardWidgetComponent implements Component {
  OrderCardWidgetComponent(BuildContext context) {
    parent = Injector.of<AppComponent>(context).component;

    messageController = MaterialMessageController.from(context);
    dialogController = OrderDialogController.from(context);
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
  OrderDialogController dialogController;
  NavigatorState navigator;
  NavigatorState rootNavigator;
  WidgetModelDependencies wmDependencies;
}

OrderCardWidgetWidgetModel createOrderCardWidgetWidgetModel(
  BuildContext context,
  NewOrder order,
) {
  final component = Injector.of<OrderCardWidgetComponent>(context).component;

  return OrderCardWidgetWidgetModel(
    component.wmDependencies,
    component.navigator,
    order,
    component.dialogController,
    component.parent.orderManager,
  );
}
