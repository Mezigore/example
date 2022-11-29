import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';

// ignore: always_use_package_imports
import '../temp_wm.dart';

/// [Component] для <$Temp$>
class $Temp$Component implements Component {
  $Temp$Component(BuildContext context) {
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

$Temp$WidgetModel create$Temp$WidgetModel(BuildContext context) {
  final component = Injector.of<$Temp$Component>(context).component;

  return $Temp$WidgetModel(component.wmDependencies, component.navigator);
}
