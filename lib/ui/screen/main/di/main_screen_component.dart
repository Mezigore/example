import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/interactor/auth/auth_manager.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/main/main_screen_wm.dart';

/// [Component] для <MainScreen>
class MainScreenComponent implements Component {
  MainScreenComponent(BuildContext context) {
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

    authManager = parent.authManager;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  AppComponent parent;
  MessageController messageController;
  DefaultDialogController dialogController;
  NavigatorState navigator;
  NavigatorState rootNavigator;
  WidgetModelDependencies wmDependencies;
  AuthManager authManager;
}

MainScreenWidgetModel createMainScreenWidgetModel(BuildContext context) {
  final component = Injector.of<MainScreenComponent>(context).component;

  return MainScreenWidgetModel(
    component.wmDependencies,
    component.authManager,
    component.navigator,
    component.dialogController,
    component.parent.menuManager,
    component.parent.cartManager,
    component.messageController,
    component.parent.appManager
  );
}
