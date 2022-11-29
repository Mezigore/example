import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/domain/cart/edit_cart_item.dart';

part 'edit_cart_item_data.g.dart';

/// Data-класс для [EditCartItem].
@JsonSerializable()
class EditCartItemData {
  EditCartItemData({
    this.id,
    this.qty,
  });

  factory EditCartItemData.fromJson(Map<String, dynamic> json) =>
      _$EditCartItemDataFromJson(json);

  final String id;
  final int qty;

  Map<String, dynamic> toJson() => _$EditCartItemDataToJson(this);
}
