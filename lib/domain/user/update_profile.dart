import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/user/gender_info.dart';

/// Обновление данных пользователя.
/// Отправлять только те поля, что меняются.
class UpdateProfile {
  UpdateProfile({
    this.birthday,
    this.gender,
    @required this.lastName,
    @required this.name,
    @required this.email,
  });

  final DateTime birthday;
  final GenderInfo gender;
  final String lastName;
  final String name;
  final String email;
}
