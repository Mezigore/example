import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/di/widget_component.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/profile/profile_wm.dart';

/// di for [ProfileWidgetModel]
class ProfileComponent extends WidgetComponent {
  ProfileComponent(BuildContext context) : super(context) {
    parent = Injector.of<AppComponent>(context).component;
    _navigator = Navigator.of(context);
    _messageController = MaterialMessageController(scaffoldKey);
    _dialogController = DefaultDialogController(scaffoldKey);
    _userManager = parent.userManager;

    _wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        _messageController,
        _dialogController,
        parent.scInteractor,
      ),
    );
  }

  AppComponent parent;
  NavigatorState _navigator;
  MessageController _messageController;
  DialogController _dialogController;
  WidgetModelDependencies _wmDependencies;
  UserManager _userManager;
}

/// builder by TemplateWm
ProfileWidgetModel createProfileWm(BuildContext context) {
  final component = Injector.of<ProfileComponent>(context).component;
  return ProfileWidgetModel(
    component._wmDependencies,
    component._navigator,
    component._userManager,
    component.scaffoldKey,
    component.parent.analyticsInteractor,
  );
}
