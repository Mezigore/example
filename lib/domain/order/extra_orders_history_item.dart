import 'package:uzhindoma/domain/order/base/history_item.dart';
import 'package:uzhindoma/domain/order/orders_history_raiting.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';

/// Информация о дополнительном (подарочном) товаре из истории заказов
class ExtraOrdersHistoryItem extends HistoryItem {
  ExtraOrdersHistoryItem({
    String id,
    String img,
    int itemRating,
    String name,
    String comment,
  }) : super(
          id,
          img,
          name,
          itemRating,
          comment,
        );

  OrdersHistoryRating _rating;

  @override
  OrdersHistoryRating get getRating {
    _rating ??= OrdersHistoryRating(
      id: id,
      comment: comment,
      itemRating: itemRating,
    );
    return _rating;
  }

  /// Возвращает копию применив оценку
  ExtraOrdersHistoryItem rate(OrdersHistoryRating rate) {
    if (rate.id != id) {
      throw UnavailableActionException(
          'Rate id = ${rate.id} not matched with extraItem id = $id.');
    }

    return ExtraOrdersHistoryItem(
      id: id,
      name: name,
      comment: rate.comment,
      img: img,
      itemRating: rate.itemRating,
    );
  }
}
