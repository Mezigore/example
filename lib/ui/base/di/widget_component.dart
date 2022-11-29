import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';

/// Base component with common dependencies.
abstract class WidgetComponent implements Component {
  WidgetComponent(
    BuildContext context, {
    MessageController messageController,
    DialogController dialogController,
    NavigatorState navigator,
  }) {
    final appComponent = Injector.of<AppComponent>(context).component;

    this.messageController =
        messageController ?? MaterialMessageController(scaffoldKey);
    this.dialogController =
        dialogController ?? DefaultDialogController(scaffoldKey);
    this.navigator = navigator ?? Navigator.of(context);

    wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        dialogController,
        appComponent.scInteractor,
      ),
    );
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  MessageController messageController;
  DialogController dialogController;
  NavigatorState navigator;
  WidgetModelDependencies wmDependencies;
}
