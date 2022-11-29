import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/select_payment_screen_wm.dart';

/// [Component] для <SelectPaymentScreen>
class SelectPaymentScreenComponent implements Component {
  SelectPaymentScreenComponent(BuildContext context) {
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

SelectPaymentScreenWidgetModel createSelectPaymentScreenWidgetModel(
    BuildContext context) {
  final component =
      Injector.of<SelectPaymentScreenComponent>(context).component;

  return SelectPaymentScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.dialogController,
    component.parent.orderManager,
    component.parent.userManager,
    component.parent.menuManager,
    component.messageController,
  );
}
