import 'package:json_annotation/json_annotation.dart';

part 'conform_change_phone.g.dart';

/// Подтверждение смены телефона
@JsonSerializable()
class ConformChangePhoneData {
  ConformChangePhoneData({
    this.code,
    this.phone,
  });

  factory ConformChangePhoneData.fromJson(Map<String, dynamic> json) =>
      _$ConformChangePhoneDataFromJson(json);

  Map<String, dynamic> toJson() => _$ConformChangePhoneDataToJson(this);

  /// Отправлять вторым запросом вместе с номером телефона
  String code;

  /// Отправлять первым запросом
  String phone;
}
