import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/cart/cart_item_data.dart';
import 'package:uzhindoma/api/data/cart/extra_item_data.dart';
import 'package:uzhindoma/api/data/catalog/week_item_data.dart';
import 'package:uzhindoma/api/data/common/key_value_data.dart';
import 'package:uzhindoma/domain/cart/cart.dart';

part 'cart_data.g.dart';

/// Data-класс для [Cart].
@JsonSerializable()
class CartData {
  CartData({
    this.minCount,
    this.minPrice,
    this.discount,
    this.discountSumm,
    this.discountCountSumm,
    this.discountConditions,
    this.price,
    this.totalPrice,
    this.discountPrice,
    this.weekItem,
    this.menu,
    this.extraItems,
  });

  factory CartData.fromJson(Map<String, dynamic> json) =>
      _$CartDataFromJson(json);

  @JsonKey(name: 'min_count')
  final int minCount;
  @JsonKey(name: 'min_price')
  final int minPrice;
  // @JsonKey(fromJson: _discountToJson)
  final int discount;
  @JsonKey(name: 'discount_summ')
  final int discountSumm;
  @JsonKey(name: 'discount_count_summ')
  final int discountCountSumm;
  @JsonKey(name: 'discount_conditions')
  final List<KeyValueData> discountConditions;
  final int price;
  @JsonKey(name: 'total_price')
  final int totalPrice;
  @JsonKey(name: 'discount_price')
  final int discountPrice;
  final WeekItemData weekItem;
  final List<CartItemData> menu;
  @JsonKey(name: 'extra_item')
  final List<ExtraItemData> extraItems;

  Map<String, dynamic> toJson() => _$CartDataToJson(this);
}
// int _discountToJson(String discount) {
//   return int.parse(discount);
// }