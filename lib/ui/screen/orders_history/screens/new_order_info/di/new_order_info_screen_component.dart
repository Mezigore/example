import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/new_order_info/new_order_info_screen_wm.dart';

import '../../../../../common/order_dialog_controller.dart';

/// [Component] для <NewOrderInfoScreen>
class NewOrderInfoScreenComponent implements Component {
  NewOrderInfoScreenComponent(BuildContext context) {
    parent = Injector.of<AppComponent>(context).component;

    messageController = MaterialMessageController(scaffoldKey);
    dialogController = DefaultDialogController(scaffoldKey);
    orderDialogController = OrderDialogController.from(context);
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
  DialogController dialogController;
  OrderDialogController orderDialogController;
  NavigatorState navigator;
  NavigatorState rootNavigator;
  WidgetModelDependencies wmDependencies;
}

NewOrderInfoScreenWidgetModel createNewOrderInfoScreenWidgetModel(
  BuildContext context,
  NewOrder order,
) {
  final component = Injector.of<NewOrderInfoScreenComponent>(context).component;

  return NewOrderInfoScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.orderDialogController,
    order,
    component.parent.orderManager,
  );
}
