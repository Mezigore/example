import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/catalog/menu/menu_item_data.dart';
import 'package:uzhindoma/api/data/catalog/menu/promo_params_item_data.dart';
import 'package:uzhindoma/domain/catalog/menu/promo_item.dart';
import 'package:uzhindoma/domain/catalog/menu/promo_params.dart';

part 'promo_item_data.g.dart';

/// Data-класс для [PromoItem].
@JsonSerializable()
class PromoItemData {
  PromoItemData({
    this.id,
    this.name,
    this.code,
    this.count,
    this.products,
    this.description,
    this.appTitle,
    this.appDescription,
    this.iconUrl,
    this.showCategoryName,
    this.params,
  });

  factory PromoItemData.fromJson(Map<String, dynamic> json) =>
      _$PromoItemDataFromJson(json);

  final String id;
  final String code;
  final String name;
  final int count;
  final List<MenuItemData> products;
  final String description;
  @JsonKey(name: 'app_title')
  final String appTitle;
  @JsonKey(name: 'app_description')
  final String appDescription;
  @JsonKey(name: 'icon_url')
  final String iconUrl;
  @JsonKey(name: 'show_category_name')
  final bool showCategoryName;
  final PromoParamsItemData params;

  Map<String, dynamic> toJson() => _$PromoItemDataToJson(this);
}
