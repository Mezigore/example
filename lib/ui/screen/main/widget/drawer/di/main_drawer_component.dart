import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/interactor/auth/auth_manager.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/main/widget/drawer/main_drawer_wm.dart';

/// [Component] для <MainDrawerWm>
class MainDrawerComponent implements Component {
  MainDrawerComponent(BuildContext context) {
    final parent = Injector.of<AppComponent>(context).component;
    _navigator = Navigator.of(context);
    messageController = MaterialMessageController.from(context);
    dialogController = DefaultDialogController.from(context);

    _wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        dialogController,
        parent.scInteractor,
      ),
    );

    authManager = parent.authManager;
  }

  NavigatorState _navigator;
  MessageController messageController;
  DialogController dialogController;
  WidgetModelDependencies _wmDependencies;

  AuthManager authManager;
}

/// builder by TemplateWm
MainDrawerWidgetModel createMainDrawerWm(BuildContext context) {
  final component = Injector.of<MainDrawerComponent>(context).component;
  return MainDrawerWidgetModel(
    component._wmDependencies,
    component._navigator,
    component.authManager,
  );
}
