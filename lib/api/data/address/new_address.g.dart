// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewAddressData _$NewAddressDataFromJson(Map<String, dynamic> json) {
  return NewAddressData(
    comment: json['comment'] as String,
    isDefault: json['default'] as bool,
    flat: json['flat'] as int,
    floor: json['floor'] as int,
    name: json['name'] as String,
    section: json['section'] as int,
  );
}

Map<String, dynamic> _$NewAddressDataToJson(NewAddressData instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'default': instance.isDefault,
      'flat': instance.flat,
      'floor': instance.floor,
      'name': instance.name,
      'section': instance.section,
    };
