// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersHistoryItemData _$OrdersHistoryItemDataFromJson(
    Map<String, dynamic> json) {
  return OrdersHistoryItemData(
    comment: json['comment'] as String,
    id: json['id'] as String,
    img: json['img'] as String,
    itemRating: json['item_rating'] as int,
    name: json['name'] as String,
    recipeRating: json['recipe_rating'] as int,
  );
}

Map<String, dynamic> _$OrdersHistoryItemDataToJson(
        OrdersHistoryItemData instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'id': instance.id,
      'img': instance.img,
      'item_rating': instance.itemRating,
      'name': instance.name,
      'recipe_rating': instance.recipeRating,
    };
