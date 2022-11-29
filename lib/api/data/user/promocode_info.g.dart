// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promocode_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromocodeInfoData _$PromocodeInfoDataFromJson(Map<String, dynamic> json) {
  return PromocodeInfoData(
    code: json['code'] as String,
    useCount: json['use_count'] as int,
  );
}

Map<String, dynamic> _$PromocodeInfoDataToJson(PromocodeInfoData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'use_count': instance.useCount,
    };
