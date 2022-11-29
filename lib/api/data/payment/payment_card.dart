import 'package:json_annotation/json_annotation.dart';

part 'payment_card.g.dart';

/// Карта оплаты
@JsonSerializable()
class PaymentCardData {
  PaymentCardData({
    this.id,
    this.name,
    this.isDefault,
  });

  factory PaymentCardData.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardDataFromJson(json);

  final String id;

  final String name;

  @JsonKey(name: 'default')
  final bool isDefault;

  Map<String, dynamic> toJson() => _$PaymentCardDataToJson(this);
}
