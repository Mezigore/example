import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/di/widget_component.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/replacement_phone_number/replacement_phone_number_wm.dart';

/// di for [ReplacementPhoneNumberWidgetModel]
class ReplacementPhoneNumberComponent extends WidgetComponent {
  ReplacementPhoneNumberComponent(BuildContext context) : super(context) {
    final parent = Injector.of<AppComponent>(context).component;
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

  NavigatorState _navigator;
  MessageController _messageController;
  DialogController _dialogController;
  WidgetModelDependencies _wmDependencies;
  UserManager _userManager;
}

/// builder by [ReplacementPhoneNumberWidgetModel]
ReplacementPhoneNumberWidgetModel createReplacementPhoneNumberWm(
    BuildContext context) {
  final component =
      Injector.of<ReplacementPhoneNumberComponent>(context).component;
  return ReplacementPhoneNumberWidgetModel(
    component._wmDependencies,
    component._navigator,
    component._userManager,
  );
}
