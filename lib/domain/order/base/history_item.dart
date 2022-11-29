import 'package:uzhindoma/domain/order/orders_history_raiting.dart';

/// Общий класс для блюд в заказе из истории
abstract class HistoryItem {
  HistoryItem(
    this.id,
    this.img,
    this.name,
    this.itemRating,
    this.comment,
  );

  /// id товара
  final String id;

  /// Ссылка на картинку
  final String img;

  final String name;

  /// Оценка блюда
  final int itemRating;

  /// Комментарий
  final String comment;

  /// Рейтинг блюда
  OrdersHistoryRating get getRating;

  bool _isRated;

  bool get isRated {
    _isRated ??= itemRating != null && itemRating != 0;
    return _isRated;
  }
}
