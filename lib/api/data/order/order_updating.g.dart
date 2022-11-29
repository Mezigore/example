// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_updating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderUpdatingData _$OrderUpdatingDataFromJson(Map<String, dynamic> json) {
  return OrderUpdatingData(
    addressComment: json['address_comment'] as String,
    addressId: json['address_id'] as int,
    cardId: json['card_id'] as String,
    date: json['date'] as String,
    paymentType:
        _$enumDecodeNullable(_$PaymentTypeDataEnumMap, json['payment_type']),
    time: json['time'] as int,
  );
}

Map<String, dynamic> _$OrderUpdatingDataToJson(OrderUpdatingData instance) =>
    <String, dynamic>{
      'address_comment': instance.addressComment,
      'address_id': instance.addressId,
      'card_id': instance.cardId,
      'date': instance.date,
      'payment_type': _$PaymentTypeDataEnumMap[instance.paymentType],
      'time': instance.time,
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

const _$PaymentTypeDataEnumMap = {
  PaymentTypeData.card: 'card',
  PaymentTypeData.cash: 'cash',
};
