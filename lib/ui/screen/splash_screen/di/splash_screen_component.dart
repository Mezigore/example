import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/interactor/auth/auth_manager.dart';
import 'package:uzhindoma/interactor/common/managers/secure_storage.dart';
import 'package:uzhindoma/interactor/debug/debug_screen_interactor.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';

/// [Component] для экрана <SplashScreen>
class SplashScreenComponent implements Component {
  SplashScreenComponent(BuildContext context, Object data) {
    final app = Injector.of<AppComponent>(context).component;

    messageController = MaterialMessageController(scaffoldKey);
    dialogController = DefaultDialogController(scaffoldKey);
    navigator = Navigator.of(context);
    authManager = app.authManager;
    secureStorage = app.secureStorage;

    wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        dialogController,
        app.scInteractor,
      ),
    );

    debugScreenInteractor = app.debugScreenInteractor;
    dataLoc = data;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  MaterialMessageController messageController;
  DefaultDialogController dialogController;
  NavigatorState navigator;
  WidgetModelDependencies wmDependencies;
  AuthManager authManager;
  SecureStorage secureStorage;
  DebugScreenInteractor debugScreenInteractor;
  Object dataLoc;
}
