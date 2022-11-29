// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_required.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpRequiredData _$OtpRequiredDataFromJson(Map<String, dynamic> json) {
  return OtpRequiredData(
    nextOtp: (json['nextOtp'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OtpRequiredDataToJson(OtpRequiredData instance) =>
    <String, dynamic>{
      'nextOtp': instance.nextOtp,
    };
