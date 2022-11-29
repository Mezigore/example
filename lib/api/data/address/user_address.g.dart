// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAddressData _$UserAddressDataFromJson(Map<String, dynamic> json) {
  return UserAddressData(
    cityId: json['city_id'] as int,
    cityName: json['city_name'] as String,
    comment: json['comment'] as String,
    coordinates: json['coordinates'] as String,
    isDefault: json['default'] as bool,
    flat: json['flat'] as int,
    floor: json['floor'] as int,
    fullName: json['full_name'] as String,
    house: json['house'] as int,
    id: json['id'] as int,
    name: json['name'] as String,
    section: json['section'] as int,
    street: json['street'] as String,
  );
}

Map<String, dynamic> _$UserAddressDataToJson(UserAddressData instance) =>
    <String, dynamic>{
      'city_id': instance.cityId,
      'city_name': instance.cityName,
      'comment': instance.comment,
      'coordinates': instance.coordinates,
      'default': instance.isDefault,
      'flat': instance.flat,
      'floor': instance.floor,
      'full_name': instance.fullName,
      'house': instance.house,
      'id': instance.id,
      'name': instance.name,
      'section': instance.section,
      'street': instance.street,
    };
