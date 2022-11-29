import 'package:uzhindoma/domain/order/extra_orders_history_item.dart';
import 'package:uzhindoma/domain/order/orders_history_item.dart';
import 'package:uzhindoma/domain/order/orders_history_raiting.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/util/date_formatter.dart';

/// Информация о заказе из истории заказов
class OrderFromHistory {
  OrderFromHistory({
    this.extraItemsFromHistory,
    this.id,
    this.itemsFromHistory,
    this.canBeRated,
    this.orderDate,
  });

  final List<ExtraOrdersHistoryItem> extraItemsFromHistory;

  /// id заказа
  final String id;

  /// Флаг, показывающий, можно ли оценить заказ
  final bool canBeRated;

  final List<OrdersHistoryItem> itemsFromHistory;

  /// Дата доставки
  final DateTime orderDate;

  bool _isRated;
  String _orderNumberTitle;
  String _orderDateTitle;

  bool get _extraIsRated =>
      extraItemsFromHistory == null ||
      extraItemsFromHistory?.indexWhere((i) => !i.isRated) == -1;

  bool get _itemsIsRated =>
      itemsFromHistory == null ||
      itemsFromHistory?.indexWhere((i) => !i.isRated) == -1;

  bool get isRated {
    _isRated ??= _extraIsRated && _itemsIsRated;
    return _isRated;
  }

  String get orderNumberTitle {
    _orderNumberTitle ??= '№ $id';
    return _orderNumberTitle;
  }

  String get orderDateTitle {
    _orderDateTitle ??= '$orderDelivered ${DateUtil.formatToDate(orderDate)}';
    return _orderDateTitle;
  }

  /// Возвращает копию с примененными оценками
  OrderFromHistory rate(
    List<OrdersHistoryRating> rates,
  ) {
    final ratesMap = <String, OrdersHistoryRating>{};
    for (final rate in rates) {
      ratesMap[rate.id] = rate;
    }

    final rateIds = ratesMap.values.map((e) => e.id).toList();

    return OrderFromHistory(
      id: id,
      orderDate: orderDate,
      itemsFromHistory: itemsFromHistory?.map(
        (item) {
          if (!rateIds.contains(item.id)) {
            return item;
          }

          return item.rate(ratesMap[item.id]);
        },
      )?.toList(),
      extraItemsFromHistory: extraItemsFromHistory?.map(
        (item) {
          if (!rateIds.contains(item.id)) {
            return item;
          }

          return item.rate(ratesMap[item.id]);
        },
      )?.toList(),
    );
  }
}
