import 'package:flutter/material.dart';

/// Представление номера телефона
/// validNumber - номер формата [+7хххххххххх]
/// uiPhoneNumber - номер формата [(ххх) ххх-хх-хх]
class PhoneNumber {
  const PhoneNumber({
    @required this.validNumber,
    @required this.uiPhoneNumber,
  });

  final String validNumber;
  final String uiPhoneNumber;
}
