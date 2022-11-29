import 'package:json_annotation/json_annotation.dart';

part 'otp_required.g.dart';

/// Модель, которая приходит, если нужен ОТП
@JsonSerializable()
class OtpRequiredData {
  OtpRequiredData({
    this.nextOtp,
  });

  factory OtpRequiredData.fromJson(Map<String, dynamic> json) =>
      _$OtpRequiredDataFromJson(json);

  Map<String, dynamic> toJson() => _$OtpRequiredDataToJson(this);

  /// Время возможной отправки следующего кода. В секундах
  double nextOtp;
}
