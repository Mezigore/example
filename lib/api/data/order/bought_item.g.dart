// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bought_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoughtItemData _$BoughtItemDataFromJson(Map<String, dynamic> json) {
  return BoughtItemData(
    discountPrice: json['discount_price'] as int,
    id: json['id'] as String,
    name: json['name'] as String,
    previewImg: json['preview_img'] as String,
    price: json['price'] as int,
  );
}

Map<String, dynamic> _$BoughtItemDataToJson(BoughtItemData instance) =>
    <String, dynamic>{
      'discount_price': instance.discountPrice,
      'id': instance.id,
      'name': instance.name,
      'preview_img': instance.previewImg,
      'price': instance.price,
    };
