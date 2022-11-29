import 'package:flutter/services.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';

const int formatPhoneLength = 15;

/// валидация номера телефона
final _phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\-\d\d$');

String validatePhoneNumber(String value) {
  if (value?.trim()?.isEmpty ?? true) return authScreenPhoneEmpty;
  if (!_phoneExp.hasMatch(value)) return authScreenPhoneWrongFormat;
  return null;
}

/// Проверка правильной почты
bool validateEmail(String text) {
  if (text == null || text.isEmpty) return false;
  const String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final RegExp regex = RegExp(pattern);
  return regex.hasMatch(text);
}

/// форматер для E-mail
final formatEmail = FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z@.]'));

/// форматер для текстового поля без пробелов Имя, Отчество, Фамилия
final formatText = FilteringTextInputFormatter.allow(RegExp('[а-яА-Я]'));
