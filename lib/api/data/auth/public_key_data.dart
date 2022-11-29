import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/domain/auth/public_key.dart';

part 'public_key_data.g.dart';

/// Data-класс для [PublicKey].
@JsonSerializable()
class PublicKeyData {
  PublicKeyData({
    @required this.publicKey,
    @required this.time,
  });

  factory PublicKeyData.fromJson(Map<String, dynamic> json) =>
      _$PublicKeyDataFromJson(json);

  final String publicKey;
  final String time;

  Map<String, dynamic> toJson() => _$PublicKeyDataToJson(this);
}
