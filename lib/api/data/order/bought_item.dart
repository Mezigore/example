import 'package:json_annotation/json_annotation.dart';

part 'bought_item.g.dart';

/// Купленный товар в составе заказа
@JsonSerializable()
class BoughtItemData {
  BoughtItemData({
    this.discountPrice,
    this.id,
    this.name,
    this.previewImg,
    this.price,
  });

  factory BoughtItemData.fromJson(Map<String, dynamic> json) =>
      _$BoughtItemDataFromJson(json);

  /// Цена со скидкой за купленный товар
  @JsonKey(name: 'discount_price')
  final int discountPrice;

  final String id;

  final String name;

  /// Ссылка на картинку для списка
  @JsonKey(name: 'preview_img')
  final String previewImg;

  /// Цена за купленный товар
  final int price;

  Map<String, dynamic> toJson() => _$BoughtItemDataToJson(this);
}
