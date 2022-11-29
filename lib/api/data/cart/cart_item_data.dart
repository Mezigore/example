import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/catalog/menu/menu_item_data.dart';
import 'package:uzhindoma/domain/cart/cart_item.dart';

part 'cart_item_data.g.dart';

/// Data-класс для [CartItem].
@JsonSerializable()
class CartItemData {
  CartItemData({
    this.id,
    this.name,
    this.previewImg,
    this.price,
    this.discountPrice,
    this.qty,
    this.ratio,
    this.type,
  });

  factory CartItemData.fromJson(Map<String, dynamic> json) =>
      _$CartItemDataFromJson(json);

  final String id;
  final String name;
  @JsonKey(name: 'preview_img')
  final String previewImg;
  final int price;
  @JsonKey(name: 'discount_price')
  final int discountPrice;
  final int qty;
  final int ratio;
  final MenuItemTypeData type;

  Map<String, dynamic> toJson() => _$CartItemDataToJson(this);
}
