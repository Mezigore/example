import 'package:json_annotation/json_annotation.dart';

part 'pay_system.g.dart';

@JsonSerializable()
class PaySystemData {
  PaySystemData({
    this.paySystem,
    this.paymentToken,
  });

  factory PaySystemData.fromJson(Map<String, dynamic> json) =>
      _$PaySystemDataFromJson(json);

  /// Платежная система
  @JsonKey(name: 'pay_system')
  final String paySystem;

  /// Токен для оплаты через Google Pay и Apple Pay
  @JsonKey(name: 'payment_token')
  final String paymentToken;

  Map<String, dynamic> toJson() => _$PaySystemDataToJson(this);
}
