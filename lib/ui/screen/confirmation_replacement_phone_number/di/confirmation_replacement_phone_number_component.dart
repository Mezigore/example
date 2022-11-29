import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/phone_number.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/di/widget_component.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/confirmation_replacement_phone_number/confirmation_replacement_phone_number_wm.dart';

/// di for [ConfirmationReplacementPhoneNumberWidgetModel]
class ConfirmationReplacementPhoneNumberComponent extends WidgetComponent {
  ConfirmationReplacementPhoneNumberComponent(BuildContext context)
      : super(context) {
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

/// builder by [ConfirmationReplacementPhoneNumberWidgetModel]
ConfirmationReplacementPhoneNumberWidgetModel
    createConfirmationReplacementPhoneNumberWm(
  BuildContext context,
  PhoneNumber phoneNumber,
) {
  final component =
      Injector.of<ConfirmationReplacementPhoneNumberComponent>(context)
          .component;
  return ConfirmationReplacementPhoneNumberWidgetModel(
    component._wmDependencies,
    component._navigator,
    phoneNumber: phoneNumber,
    userManager: component._userManager,
  );
}
