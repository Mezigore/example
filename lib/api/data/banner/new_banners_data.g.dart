// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_banners_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewBannersData _$NewBannersDataFromJson(Map<String, dynamic> json) {
  return NewBannersData(
    id: json['ID'] as String,
    name: json['NAME'] as String,
    sort: json['SORT'] as String,
    image: json['IMAGE'] as String,
    type: json['TYPE'] as String,
    value: json['VALUE'] as String,
    size: json['SIZE'] as String,
  );
}

Map<String, dynamic> _$NewBannersDataToJson(NewBannersData instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'NAME': instance.name,
      'SORT': instance.sort,
      'IMAGE': instance.image,
      'TYPE': instance.type,
      'VALUE': instance.value,
      'size': instance.size,
    };
