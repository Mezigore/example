import 'package:json_annotation/json_annotation.dart';

part 'favourite_item.g.dart';

/// Вариант любимого блюда
@JsonSerializable()
class FavouriteItemData {
  FavouriteItemData({
    this.id,
    this.name,
  });

  factory FavouriteItemData.fromJson(Map<String, dynamic> json) =>
      _$FavouriteItemDataFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteItemDataToJson(this);

  int id;

  String name;
}
