import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/catalog/menu/menu_item_data.dart';
import 'package:uzhindoma/domain/catalog/menu/recommendation_item.dart';

part 'recommendation_item_data.g.dart';

/// Data-класс для [RecommendationItem].
@JsonSerializable()
class RecommendationItemData {
  RecommendationItemData({
    this.title,
    this.products,
  });

  factory RecommendationItemData.fromJson(Map<String, dynamic> json) => _$RecommendationItemDataFromJson(json);

  final String title;
  final List<MenuItemData> products;

  Map<String, dynamic> toJson() => _$RecommendationItemDataToJson(this);
}
