// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_client_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllClientInfoData _$AllClientInfoDataFromJson(Map<String, dynamic> json) {
  return AllClientInfoData(
      birthday: json['birthday'] as String,
      bonus: json['bonus'] as int,
      discount: json['discount'] as int,
      favourite: (json['favourite'] as List)
          ?.map((e) => e == null
              ? null
              : FavouriteItemData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      gender: _$enumDecodeNullable(_$GenderInfoDataEnumMap, json['gender'],
          unknownValue: GenderInfoData.unknownValue),
      id: json['id'] as String,
      isNew: json['is_new'] as bool,
      lastName: json['last_name'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      promocode: json['promocode'] == null
          ? null
          : PromocodeInfoData.fromJson(
              json['promocode'] as Map<String, dynamic>),
      referral: json['referral'] as String,
      email: json['email'] as String,
      noBirthdayText: json['no_birthday_text'] as String,
      noFavouriteText: json['no_favourite_text'] as String);
}

Map<String, dynamic> _$AllClientInfoDataToJson(AllClientInfoData instance) =>
    <String, dynamic>{
      'birthday': instance.birthday,
      'bonus': instance.bonus,
      'discount': instance.discount,
      'favourite': instance.favourite,
      'gender': _$GenderInfoDataEnumMap[instance.gender],
      'id': instance.id,
      'is_new': instance.isNew,
      'last_name': instance.lastName,
      'name': instance.name,
      'phone': instance.phone,
      'promocode': instance.promocode,
      'referral': instance.referral,
      'email': instance.email,
      'no_birthday_text': instance.noBirthdayText,
      'no_favourite_text': instance.noFavouriteText
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
