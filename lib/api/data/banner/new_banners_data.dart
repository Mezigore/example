import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/domain/banner/banner.dart';

part 'new_banners_data.g.dart';

/// Data-класс для [Banner]
@JsonSerializable()
class NewBannersData {
  NewBannersData({
    this.id,
    this.name,
    this.sort,
    this.image,
    this.type,
    this.value,
    this.size,
  });

  factory NewBannersData.fromJson(Map<String, dynamic> json) =>
      _$NewBannersDataFromJson(json);

  @JsonKey(name: 'ID')
  final String id;
  @JsonKey(name: 'NAME')
  final String name;
  @JsonKey(name: 'SORT')
  final String sort;
  @JsonKey(name: 'IMAGE')
  final String image;
  @JsonKey(name: 'TYPE')
  final String type;
  @JsonKey(name: 'VALUE')
  final String value;
  @JsonKey(name: 'SIZE')
  final String size;

  Map<String, dynamic> toJson() => _$NewBannersDataToJson(this);
}
