import 'package:json_annotation/json_annotation.dart';

part 'change_conditions.g.dart';

/// Параметры в заказе, которые можно изменить
@JsonSerializable()
class ChangeConditionsData {
  ChangeConditionsData({
    this.canChangeAddress,
    this.canChangeDeliveryDate,
    this.canChangePaymentType,
  });

  factory ChangeConditionsData.fromJson(Map<String, dynamic> json) =>
      _$ChangeConditionsDataFromJson(json);

  /// Можно ли изменить адрес доставки
  @JsonKey(name: 'can_change_address')
  final bool canChangeAddress;

  /// Можно ли изменить дату и время доставки
  @JsonKey(name: 'can_change_delivery_date')
  final bool canChangeDeliveryDate;

  /// Можно ли изменить способ оплаты
  @JsonKey(name: 'can_change_payment_type')
  final bool canChangePaymentType;

  Map<String, dynamic> toJson() => _$ChangeConditionsDataToJson(this);
}
