// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_system.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaySystemData _$PaySystemDataFromJson(Map<String, dynamic> json) {
  return PaySystemData(
    paySystem: json['pay_system'] as String,
    paymentToken: json['payment_token'] as String,
  );
}

Map<String, dynamic> _$PaySystemDataToJson(PaySystemData instance) =>
    <String, dynamic>{
      'pay_system': instance.paySystem,
      'payment_token': instance.paymentToken,
    };
