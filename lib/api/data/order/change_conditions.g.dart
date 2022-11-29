// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_conditions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeConditionsData _$ChangeConditionsDataFromJson(Map<String, dynamic> json) {
  return ChangeConditionsData(
    canChangeAddress: json['can_change_address'] as bool,
    canChangeDeliveryDate: json['can_change_delivery_date'] as bool,
    canChangePaymentType: json['can_change_payment_type'] as bool,
  );
}

Map<String, dynamic> _$ChangeConditionsDataToJson(
        ChangeConditionsData instance) =>
    <String, dynamic>{
      'can_change_address': instance.canChangeAddress,
      'can_change_delivery_date': instance.canChangeDeliveryDate,
      'can_change_payment_type': instance.canChangePaymentType,
    };
