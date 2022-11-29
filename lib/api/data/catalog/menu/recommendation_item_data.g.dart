// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_item_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationItemData _$RecommendationItemDataFromJson(
    Map<String, dynamic> json) {
  return RecommendationItemData(
    title: json['title'] as String,
    products: (json['products'] as List)
        ?.map((e) =>
            e == null ? null : MenuItemData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RecommendationItemDataToJson(
        RecommendationItemData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'products': instance.products,
    };
