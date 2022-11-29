// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokensData _$TokensDataFromJson(Map<String, dynamic> json) {
  return TokensData(
    accessToken: json['access_token'] as String,
    tokenType: json['token_type'] as String,
    issued: json['issued'] == null
        ? null
        : DateTime.parse(json['issued'] as String),
    expires: json['expires'] == null
        ? null
        : DateTime.parse(json['expires'] as String),
    refreshToken: json['refresh_token'] as String,
    userId: json['user_id'] as String,
  );
}

Map<String, dynamic> _$TokensDataToJson(TokensData instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'issued': instance.issued?.toIso8601String(),
      'expires': instance.expires?.toIso8601String(),
      'refresh_token': instance.refreshToken,
      'user_id': instance.userId,
    };
