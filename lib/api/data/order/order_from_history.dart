import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/order/extra_orders_history_item.dart';
import 'package:uzhindoma/api/data/order/orders_history_item.dart';

part 'order_from_history.g.dart';

/// Информация о заказе из истории заказов
@JsonSerializable()
class OrderFromHistoryData {
  OrderFromHistoryData({
    this.extraItemsFromHistory,
    this.id,
    this.canBeRated,
    this.itemsFromHistory,
    this.orderDate,
  });

  factory OrderFromHistoryData.fromJson(Map<String, dynamic> json) =>
      _$OrderFromHistoryDataFromJson(json);

  @JsonKey(name: 'extra_items_from_history')
  final List<ExtraOrdersHistoryItemData> extraItemsFromHistory;

  /// id заказа
  final String id;

  @JsonKey(name: 'can_be_rated')
  final bool canBeRated;

  @JsonKey(name: 'items_from_history')
  final List<OrdersHistoryItemData> itemsFromHistory;

  /// Дата доставки в формате ISO 8601 "yyyy-MM-dd"
  @JsonKey(name: 'order_date')
  final String orderDate;

  Map<String, dynamic> toJson() => _$OrderFromHistoryDataToJson(this);
}
