// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'created_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatedOrderData _$CreatedOrderDataFromJson(Map<String, dynamic> json) {
  return CreatedOrderData(
    addressId: json['address_id'] as int,
    addressComment: json['address_comment'] as String,
    bonusAmount: json['bonus_amount'] as int,
    cardId: json['card_id'] as String,
    date: json['date'] as String,
    name: json['name'] as String,
    paymentType:
        _$enumDecodeNullable(_$PaymentTypeDataEnumMap, json['payment_type']),
    phone: json['phone'] as String,
    promoCode: json['promocode'] as String,
    time: json['time'] as int,
    isNoPaperRecipe: json['no_paper_reciре'] as bool,
    isPromo: json['is_promo'] as int,
  );
}

Map<String, dynamic> _$CreatedOrderDataToJson(CreatedOrderData instance) =>
    <String, dynamic>{
      'address_id': instance.addressId,
      'address_comment': instance.addressComment,
      'bonus_amount': instance.bonusAmount,
      'card_id': instance.cardId,
      'date': instance.date,
      'name': instance.name,
      'payment_type': _$PaymentTypeDataEnumMap[instance.paymentType],
      'phone': instance.phone,
      'promocode': instance.promoCode,
      'time': instance.time,
      'no_paper_reciре': instance.isNoPaperRecipe,
      'is_promo': instance.isPromo,
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
