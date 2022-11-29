import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';

// ignore: always_use_package_imports
import '../onboarding_screen_wm.dart';

/// [Component] для <OnboardingScreen>
class OnboardingScreenComponent implements Component {
  OnboardingScreenComponent(BuildContext context) {
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

OnboardingScreenWidgetModel createOnboardingScreenWidgetModel(
    BuildContext context) {
  final component = Injector.of<OnboardingScreenComponent>(context).component;

  return OnboardingScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.parent.authManager,
    component.parent.secureStorage,
  );
}
