// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_from_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderFromHistoryData _$OrderFromHistoryDataFromJson(Map<String, dynamic> json) {
  return OrderFromHistoryData(
    extraItemsFromHistory: (json['extra_items_from_history'] as List)
        ?.map((e) => e == null
            ? null
            : ExtraOrdersHistoryItemData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as String,
    canBeRated: json['can_be_rated'] as bool,
    itemsFromHistory: (json['items_from_history'] as List)
        ?.map((e) => e == null
            ? null
            : OrdersHistoryItemData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    orderDate: json['order_date'] as String,
  );
}

Map<String, dynamic> _$OrderFromHistoryDataToJson(
        OrderFromHistoryData instance) =>
    <String, dynamic>{
      'extra_items_from_history': instance.extraItemsFromHistory,
      'id': instance.id,
      'can_be_rated': instance.canBeRated,
      'items_from_history': instance.itemsFromHistory,
      'order_date': instance.orderDate,
    };
