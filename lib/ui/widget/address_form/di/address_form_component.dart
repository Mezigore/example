import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';

// ignore: always_use_package_imports
import '../address_form_wm.dart';

/// [Component] для <AddressForm>
class AddressFormComponent implements Component {
  AddressFormComponent(BuildContext context) {
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
  DialogController dialogController;
  NavigatorState navigator;
  NavigatorState rootNavigator;
  WidgetModelDependencies wmDependencies;
}

AddressFormWidgetModel createAddressFormWidgetModel(
  BuildContext context,
  NewAddress initAddress,
  ValueChanged<NewAddress> onAddressAccepted,
) {
  final component = Injector.of<AddressFormComponent>(context).component;

  return AddressFormWidgetModel(
    component.wmDependencies,
    initAddress,
    onAddressAccepted,
  );
}
