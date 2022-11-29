import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/domain/catalog/city_item.dart';

part 'city_item_data.g.dart';

/// Data-класс для [CityItem].
@JsonSerializable()
class CityItemData {
  CityItemData({
    this.id,
    this.name,
  });

  factory CityItemData.fromJson(Map<String, dynamic> json) =>
      _$CityItemDataFromJson(json);

  final String id;
  final String name;

  Map<String, dynamic> toJson() => _$CityItemDataToJson(this);
}
