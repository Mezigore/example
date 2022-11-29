import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/phone_number.dart';
import 'package:uzhindoma/ui/screen/confirmation/confirmation_screen.dart';

/// Route for [ConfirmationScreen]
class ConfirmationRoute extends MaterialPageRoute<void> {
  ConfirmationRoute({@required PhoneNumber phoneNumber})
      : super(
          builder: (ctx) => ConfirmationScreen(
            phoneNumber: phoneNumber,
          ),
        );
}
