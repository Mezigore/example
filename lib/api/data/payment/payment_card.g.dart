// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentCardData _$PaymentCardDataFromJson(Map<String, dynamic> json) {
  return PaymentCardData(
    id: json['id'] as String,
    name: json['name'] as String,
    isDefault: json['default'] as bool,
  );
}

Map<String, dynamic> _$PaymentCardDataToJson(PaymentCardData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'default': instance.isDefault,
    };
