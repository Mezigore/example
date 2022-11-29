// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_item_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoItemData _$PromoItemDataFromJson(Map<String, dynamic> json) {
  return PromoItemData(
    id: json['id'] as String,
    name: json['name'] as String,
    code: json['code'] as String,
    count: json['count'] as int,
    products: (json['products'] as List)
        ?.map((e) =>
    e == null ? null : MenuItemData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    description: json['description'] as String,
    appTitle: json['app_title'] as String,
    appDescription: json['app_description'] as String,
    iconUrl: json['icon_url'] as String,
    showCategoryName: json['show_category_name'] as bool,
    params: json['params'] == null ? null : PromoParamsItemData.fromJson(json['params'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PromoItemDataToJson(PromoItemData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'count': instance.count,
      'products': instance.products,
      'description': instance.description,
      'app_title': instance.appTitle,
      'app_description': instance.appDescription,
      'icon_url': instance.iconUrl,
      'show_category_name': instance.showCategoryName,
      'params': instance.params,
    };
