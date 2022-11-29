// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_orders_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraOrdersHistoryItemData _$ExtraOrdersHistoryItemDataFromJson(
    Map<String, dynamic> json) {
  return ExtraOrdersHistoryItemData(
    comment: json['comment'] as String,
    id: json['id'] as String,
    img: json['img'] as String,
    itemRating: json['item_rating'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ExtraOrdersHistoryItemDataToJson(
        ExtraOrdersHistoryItemData instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'id': instance.id,
      'img': instance.img,
      'item_rating': instance.itemRating,
      'name': instance.name,
    };
