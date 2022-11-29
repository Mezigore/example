import 'package:json_annotation/json_annotation.dart';

part 'orders_history_item.g.dart';

/// Информация о товаре из истории заказов
@JsonSerializable()
class OrdersHistoryItemData {
  OrdersHistoryItemData({
    this.comment,
    this.id,
    this.img,
    this.itemRating,
    this.name,
    this.recipeRating,
  });

  factory OrdersHistoryItemData.fromJson(Map<String, dynamic> json) =>
      _$OrdersHistoryItemDataFromJson(json);

  /// Комментарий к заказу
  final String comment;

  /// id товара
  final String id;

  /// Ссылка на картинку
  final String img;

  /// Оценка блюда
  @JsonKey(name: 'item_rating')
  final int itemRating;

  final String name;

  /// Оценка рецепта
  @JsonKey(name: 'recipe_rating')
  final int recipeRating;

  Map<String, dynamic> toJson() => _$OrdersHistoryItemDataToJson(this);
}
