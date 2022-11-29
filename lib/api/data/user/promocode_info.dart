import 'package:json_annotation/json_annotation.dart';

part 'promocode_info.g.dart';

/// Информация о пользователе
@JsonSerializable()
class PromocodeInfoData {
  PromocodeInfoData({
    this.code,
    this.useCount,
  });

  factory PromocodeInfoData.fromJson(Map<String, dynamic> json) =>
      _$PromocodeInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$PromocodeInfoDataToJson(this);

  String code;

  @JsonKey(name: 'use_count')
  int useCount;
}
