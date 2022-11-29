import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/create_address/create_order_address_screen_wm.dart';

/// [Component] для <SelectAddressScreen>
class CreateOrderAddressScreenComponent implements Component {
  CreateOrderAddressScreenComponent(BuildContext context) {
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

CreateOrderScreenWidgetModel createSelectAddressScreenWidgetModel(
  BuildContext context,
  // ignore: avoid_positional_boolean_parameters
  bool canGoBack,
) {
  final component =
      Injector.of<CreateOrderAddressScreenComponent>(context).component;

  return CreateOrderScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.dialogController,
    component.parent.userManager,
    canGoBack,
  );
}
