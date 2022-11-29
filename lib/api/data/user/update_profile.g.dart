// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileData _$UpdateProfileDataFromJson(Map<String, dynamic> json) {
  return UpdateProfileData(
    birthday: json['birthday'] as String,
    gender: _$enumDecodeNullable(_$GenderInfoDataEnumMap, json['gender']),
    lastName: json['last_name'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UpdateProfileDataToJson(UpdateProfileData instance) =>
    <String, dynamic>{
      'birthday': instance.birthday,
      'gender': _$GenderInfoDataEnumMap[instance.gender],
      'last_name': instance.lastName,
      'name': instance.name,
      'email': instance.email,
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

const _$GenderInfoDataEnumMap = {
  GenderInfoData.F: 'F',
  GenderInfoData.M: 'M',
  GenderInfoData.unknownValue: 'unknownValue',
};
