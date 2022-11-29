// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonErrorData _$CommonErrorDataFromJson(Map<String, dynamic> json) {
  return CommonErrorData(
    code: json['code'] as int,
    developerMessage: json['developerMessage'] as String,
    userMessage: json['userMessage'] as String,
  );
}

Map<String, dynamic> _$CommonErrorDataToJson(CommonErrorData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'developerMessage': instance.developerMessage,
      'userMessage': instance.userMessage,
    };
