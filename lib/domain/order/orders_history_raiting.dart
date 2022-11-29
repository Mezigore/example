import 'package:uzhindoma/domain/order/rating_reason.dart';

/// Товар для оценки
class OrdersHistoryRating {
  OrdersHistoryRating({
    this.comment,
    this.id,
    this.itemRating,
    this.recipeRating,
    this.reason,
  });

  /// Комментарий к заказу
  final String comment;

  /// id товара
  final String id;

  /// Оценка блюда
  final int itemRating;

  /// Оценка рецепта
  final int recipeRating;

  /// Причина низкой оценки
  final RatingReason reason;

  OrdersHistoryRating copyWith({
    String comment,
    String id,
    int itemRating,
    int recipeRating,
    RatingReason reason,
  }) {
    if ((comment == null || identical(comment, this.comment)) &&
        (id == null || identical(id, this.id)) &&
        (itemRating == null || identical(itemRating, this.itemRating)) &&
        (recipeRating == null || identical(recipeRating, this.recipeRating)) &&
        (reason == null || identical(reason, this.reason))) {
      return this;
    }

    return OrdersHistoryRating(
      comment: comment ?? this.comment,
      id: id ?? this.id,
      itemRating: itemRating ?? this.itemRating,
      recipeRating: recipeRating ?? this.recipeRating,
      reason: reason ?? this.reason,
    );
  }

  OrdersHistoryRating merge(OrdersHistoryRating rating) {
    return OrdersHistoryRating(
      comment: rating.comment ?? comment,
      id: rating.id ?? id,
      itemRating: rating.itemRating ?? itemRating,
      recipeRating: rating.recipeRating ?? recipeRating,
      reason: rating.reason ?? reason,
    );
  }
}
