import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/interactor/auth/auth_manager.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/di/widget_component.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/profile/di/profile_component.dart';
import 'package:uzhindoma/ui/screen/profile/tabs/user_details/user_details_wm.dart';

/// di for [UserDetailsWidgetModel]
class UserDetailsComponent extends WidgetComponent {
  UserDetailsComponent(BuildContext context) : super(context) {
    final root = Injector.of<AppComponent>(context).component;
    final parent = Injector.of<ProfileComponent>(context).component;
    final parent2 = Injector.of<AppComponent>(context).component;
    parentScaffoldKey = parent.scaffoldKey;
    _navigator = Navigator.of(context, rootNavigator: true);
    _messageController = MaterialMessageController(parentScaffoldKey);
    _dialogController = DefaultDialogController(scaffoldKey);
    _dialogController2 = DefaultDialogController.from(context);
    _userManager = root.userManager;
    _bottomSheetDatePickerDialogController =
        BottomSheetDatePickerDialogController(parentScaffoldKey);

    _wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        _messageController,
        _dialogController,
        root.scInteractor,
      ),
    );
    authManager = parent2.authManager;
  }

  NavigatorState _navigator;
  MaterialMessageController _messageController;
  DialogController _dialogController;
  DefaultDialogController _dialogController2;
  WidgetModelDependencies _wmDependencies;
  UserManager _userManager;
  GlobalKey<ScaffoldState> parentScaffoldKey;
  BottomSheetDatePickerDialogController _bottomSheetDatePickerDialogController;
  AuthManager authManager;
}

/// builder by TemplateWm
UserDetailsWidgetModel createUserDetailsWm(BuildContext context) {
  final component = Injector.of<UserDetailsComponent>(context).component;
  return UserDetailsWidgetModel(
    component._wmDependencies,
    component._navigator,
    component._userManager,
    component.parentScaffoldKey,
    component._messageController,
    component._bottomSheetDatePickerDialogController,
    component._dialogController2,
    component.authManager,
  );
}
