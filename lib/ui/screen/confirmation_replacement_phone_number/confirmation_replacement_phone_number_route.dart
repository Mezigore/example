import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/phone_number.dart';
import 'package:uzhindoma/ui/screen/confirmation_replacement_phone_number/confirmation_replacement_phone_number_screen.dart';

/// Route for [ConfirmationReplacementPhoneNumberScreen]
class ConfirmationReplacementPhoneNumberRoute extends MaterialPageRoute<void> {
  ConfirmationReplacementPhoneNumberRoute(PhoneNumber phoneNumber)
      : super(
          builder: (ctx) => ConfirmationReplacementPhoneNumberScreen(
            phoneNumber: phoneNumber,
          ),
        );
}
