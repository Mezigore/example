import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/domain/auth/next_time_otp.dart';

part 'next_time_otp_data.g.dart';

/// Data-класс для [NextTimeOtp].
@JsonSerializable()
class NextTimeOtpData {
  NextTimeOtpData({
    @required this.nextOtp,
  });

  factory NextTimeOtpData.fromJson(Map<String, dynamic> json) =>
      _$NextTimeOtpDataFromJson(json);

  final int nextOtp;

  Map<String, dynamic> toJson() => _$NextTimeOtpDataToJson(this);
}
