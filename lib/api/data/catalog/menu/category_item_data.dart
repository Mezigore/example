import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/catalog/menu/menu_item_data.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';

part 'category_item_data.g.dart';

/// Data-класс для [CategoryItem].
@JsonSerializable()
class CategoryItemData {
  CategoryItemData({
    this.id,
    this.name,
    this.code,
    this.count,
    this.products,
    this.description,
    this.iconUrl,
    this.showCategoryName,
    this.isBigCards,
  });

  factory CategoryItemData.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemDataFromJson(json);

  final String id;
  final String code;
  final String name;
  final int count;
  final List<MenuItemData> products;
  final String description;
  @JsonKey(name: 'icon_url')
  final String iconUrl;
  @JsonKey(name: 'show_category_name')
  final bool showCategoryName;
  @JsonKey(name: 'is_big_cards')
  final int isBigCards;

  Map<String, dynamic> toJson() => _$CategoryItemDataToJson(this);
}
