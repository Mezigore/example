// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItemData _$MenuItemDataFromJson(Map<String, dynamic> json) {
  return MenuItemData(
    id: json['id'] as String,
    name: json['name'] as String,
    previewImg: json['preview_img'] as String,
    detailImg: json['detail_img'] as String,
    price: json['price'] as int,
    promoPrice: json['promo_price'] as int,
    measureUnit: json['measure_unit'] as String,
    properties: json['properties'] == null
        ? null
        : PropertiesMenuItemData.fromJson(
            json['properties'] as Map<String, dynamic>),
    type: _$enumDecodeNullable(_$MenuItemTypeDataEnumMap, json['type']),
    isAvailable: json['is_available'] as bool,
  );
}

Map<String, dynamic> _$MenuItemDataToJson(MenuItemData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'preview_img': instance.previewImg,
      'detail_img': instance.detailImg,
      'price': instance.price,
      'promo_price': instance.promoPrice,
      'measure_unit': instance.measureUnit,
      'properties': instance.properties,
      'type': _$MenuItemTypeDataEnumMap[instance.type],
      'is_available': instance.isAvailable,
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
