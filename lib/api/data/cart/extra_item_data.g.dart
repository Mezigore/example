// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_item_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraItemData _$ExtraItemDataFromJson(Map<String, dynamic> json) {
  return ExtraItemData(
    id: json['id'] as String,
    name: json['name'] as String,
    previewImg: json['preview_img'] as String,
    price: json['price'] as int,
  );
}

Map<String, dynamic> _$ExtraItemDataToJson(ExtraItemData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'preview_img': instance.previewImg,
      'price': instance.price,
    };
