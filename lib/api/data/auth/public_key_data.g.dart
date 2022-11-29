// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_key_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicKeyData _$PublicKeyDataFromJson(Map<String, dynamic> json) {
  return PublicKeyData(
    publicKey: json['publicKey'] as String,
    time: json['time'] as String,
  );
}

Map<String, dynamic> _$PublicKeyDataToJson(PublicKeyData instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'time': instance.time,
    };
