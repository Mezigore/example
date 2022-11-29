import 'package:json_annotation/json_annotation.dart';

part 'extra_orders_history_item.g.dart';

/// Информация о дополнительном (подарочном) товаре из истории заказов
@JsonSerializable()
class ExtraOrdersHistoryItemData {
  ExtraOrdersHistoryItemData({
    this.comment,
    this.id,
    this.img,
    this.itemRating,
    this.name,
  });

  factory ExtraOrdersHistoryItemData.fromJson(Map<String, dynamic> json) =>
      _$ExtraOrdersHistoryItemDataFromJson(json);

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

  Map<String, dynamic> toJson() => _$ExtraOrdersHistoryItemDataToJson(this);
}
