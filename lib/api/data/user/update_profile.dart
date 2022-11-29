import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/user/gender_info.dart';

part 'update_profile.g.dart';

/// Обновление данных пользователя. Отправлять только те поля, что меняются
@JsonSerializable()
class UpdateProfileData {
  UpdateProfileData({
    this.birthday,
    this.gender,
    this.lastName,
    this.name,
    this.email,
  });

  factory UpdateProfileData.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileDataToJson(this);

  final String birthday;

  final GenderInfoData gender;

  @JsonKey(name: 'last_name')
  final String lastName;

  final String name;

  final String email;
}
