import 'package:uzhindoma/domain/order/base/history_item.dart';
import 'package:uzhindoma/domain/order/orders_history_raiting.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';

/// Информация о товаре из истории заказов
class OrdersHistoryItem extends HistoryItem {
  OrdersHistoryItem({
    String comment,
    String id,
    String img,
    int itemRating,
    String name,
    this.recipeRating,
  }) : super(
          id,
          img,
          name,
          itemRating,
          comment,
        );

  /// Оценка рецепта
  final int recipeRating;

  OrdersHistoryRating _rating;

  @override
  OrdersHistoryRating get getRating {
    _rating ??= OrdersHistoryRating(
      id: id,
      comment: comment,
      recipeRating: recipeRating,
      itemRating: itemRating,
    );
    return _rating;
  }

  /// Возвращает копию применив оценку
  OrdersHistoryItem rate(OrdersHistoryRating rate) {
    if (rate.id != id) {
      throw UnavailableActionException(
          'Rate id = ${rate.id} not matched with item id = $id.');
    }

    return OrdersHistoryItem(
      id: id,
      name: name,
      comment: rate.comment,
      img: img,
      itemRating: rate.itemRating,
      recipeRating: rate.recipeRating,
    );
  }
}
