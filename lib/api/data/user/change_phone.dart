import 'package:json_annotation/json_annotation.dart';

part 'change_phone.g.dart';

/// Новый номер телефона для привязки его в профиль
@JsonSerializable()
class ChangePhoneData {
  ChangePhoneData({
    this.phone,
  });

  factory ChangePhoneData.fromJson(Map<String, dynamic> json) =>
      _$ChangePhoneDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePhoneDataToJson(this);

  /// Отправлять первым запросом
  String phone;
}
