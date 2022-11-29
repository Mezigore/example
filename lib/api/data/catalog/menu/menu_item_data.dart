import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/catalog/menu/properties_menu_item_data.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';

part 'menu_item_data.g.dart';

/// Data-класс для [MenuItem].
@JsonSerializable()
class MenuItemData {
  MenuItemData({
    this.id,
    this.name,
    this.previewImg,
    this.detailImg,
    this.price,
    this.promoPrice,
    this.measureUnit,
    this.properties,
    this.type,
    this.isAvailable,
  });

  factory MenuItemData.fromJson(Map<String, dynamic> json) =>
      _$MenuItemDataFromJson(json);

  final String id;
  final String name;
  @JsonKey(name: 'preview_img')
  final String previewImg;
  @JsonKey(name: 'detail_img')
  final String detailImg;
  final int price;
  @JsonKey(name: 'promo_price')
  final int promoPrice;
  @JsonKey(name: 'measure_unit')
  final String measureUnit;
  final PropertiesMenuItemData properties;
  final MenuItemTypeData type;
  @JsonKey(name: 'is_available')
  final bool isAvailable;

  Map<String, dynamic> toJson() => _$MenuItemDataToJson(this);
}

/// Data-класс для [MenuItemType].
enum MenuItemTypeData {
  @JsonValue('premium')
  premium,
  @JsonValue('common')
  common,
  @JsonValue('extra')
  extra,
}
