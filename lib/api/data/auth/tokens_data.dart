import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/domain/auth/tokens.dart';

part 'tokens_data.g.dart';

/// Data-класс для [Tokens].
@JsonSerializable()
class TokensData {
  TokensData({
    @required this.accessToken,
    @required this.tokenType,
    @required this.issued,
    @required this.expires,
    @required this.refreshToken,
    @required this.userId,
  });

  factory TokensData.fromJson(Map<String, dynamic> json) =>
      _$TokensDataFromJson(json);

  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'token_type')
  final String tokenType;
  final DateTime issued;
  final DateTime expires;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'user_id')
  final String userId;

  Map<String, dynamic> toJson() => _$TokensDataToJson(this);
}
