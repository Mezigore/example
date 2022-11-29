// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_item_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItemData _$CategoryItemDataFromJson(Map<String, dynamic> json) {
  return CategoryItemData(
    id: json['id'] as String,
    name: json['name'] as String,
    code: json['code'] as String,
    count: json['count'] as int,
    products: (json['products'] as List)
        ?.map((e) =>
            e == null ? null : MenuItemData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    description: json['description'] as String,
    iconUrl: json['icon_url'] as String,
    showCategoryName: json['show_category_name'] as bool,
    isBigCards: json['is_big_cards'] as int,
  );
}

Map<String, dynamic> _$CategoryItemDataToJson(CategoryItemData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'count': instance.count,
      'products': instance.products,
      'description': instance.description,
      'icon_url': instance.iconUrl,
      'show_category_name': instance.showCategoryName,
      'is_big_cards': instance.isBigCards,
    };
