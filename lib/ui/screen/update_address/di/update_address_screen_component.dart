import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/update_address/update_address_screen_wm.dart';

/// [Component] для <UpdateAddressScreen>
class UpdateAddressScreenComponent implements Component {
  UpdateAddressScreenComponent(BuildContext context) {
    parent = Injector.of<AppComponent>(context).component;

    messageController = MaterialMessageController(scaffoldKey);
    dialogController = DefaultDialogController(scaffoldKey);
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
  DefaultDialogController dialogController;
  NavigatorState navigator;
  NavigatorState rootNavigator;
  WidgetModelDependencies wmDependencies;
}

UpdateAddressScreenWidgetModel createUpdateAddressScreenWidgetModel(
  BuildContext context,
  int addressId,
) {
  final component =
      Injector.of<UpdateAddressScreenComponent>(context).component;

  return UpdateAddressScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.parent.userManager,
    addressId,
    component.dialogController,
  );
}
