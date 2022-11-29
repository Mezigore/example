import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/domain/cart/extra_item.dart';

part 'extra_item_data.g.dart';

/// Data-класс для [ExtraItem].
@JsonSerializable()
class ExtraItemData {
  ExtraItemData({
    this.id,
    this.name,
    this.previewImg,
    this.price,
  });

  factory ExtraItemData.fromJson(Map<String, dynamic> json) =>
      _$ExtraItemDataFromJson(json);

  final String id;
  final String name;
  @JsonKey(name: 'preview_img')
  final String previewImg;
  final int price;

  Map<String, dynamic> toJson() => _$ExtraItemDataToJson(this);
}
