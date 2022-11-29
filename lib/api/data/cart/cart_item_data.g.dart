// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemData _$CartItemDataFromJson(Map<String, dynamic> json) {
  return CartItemData(
    id: json['id'] as String,
    name: json['name'] as String,
    previewImg: json['preview_img'] as String,
    price: json['price'] as int,
    discountPrice: json['discount_price'] as int,
    qty: json['qty'] as int,
    ratio: json['ratio'] as int,
    type: _$enumDecodeNullable(_$MenuItemTypeDataEnumMap, json['type']),
  );
}

Map<String, dynamic> _$CartItemDataToJson(CartItemData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'preview_img': instance.previewImg,
      'price': instance.price,
      'discount_price': instance.discountPrice,
      'qty': instance.qty,
      'ratio': instance.ratio,
      'type': _$MenuItemTypeDataEnumMap[instance.type],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$MenuItemTypeDataEnumMap = {
  MenuItemTypeData.premium: 'premium',
  MenuItemTypeData.common: 'common',
  MenuItemTypeData.extra: 'extra',
};
