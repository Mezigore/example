import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/order/raiting_reason.dart';

part 'orders_history_rating.g.dart';

/// Товар для оценки
@JsonSerializable()
class OrdersHistoryRatingData {
  OrdersHistoryRatingData({
    this.comment,
    this.id,
    this.itemRating,
    this.recipeRating,
    this.reason,
  });

  factory OrdersHistoryRatingData.fromJson(Map<String, dynamic> json) =>
      _$OrdersHistoryRatingDataFromJson(json);

  /// Комментарий к заказу
  final String comment;

  /// id товара
  final String id;

  /// Оценка блюда
  @JsonKey(name: 'item_rating')
  final int itemRating;

  /// Оценка рецепта
  @JsonKey(name: 'recipe_rating')
  final int recipeRating;

  final RatingReasonData reason;

  Map<String, dynamic> toJson() => _$OrdersHistoryRatingDataToJson(this);
}
