import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/order/payment_type.dart';

part 'order_updating.g.dart';

/// Изменение заказа
@JsonSerializable()
class OrderUpdatingData {
  OrderUpdatingData({
    this.addressComment,
    this.addressId,
    this.cardId,
    this.date,
    this.paymentType,
    this.time,
  });

  factory OrderUpdatingData.fromJson(Map<String, dynamic> json) =>
      _$OrderUpdatingDataFromJson(json);

  /// Комментарий к адресу
  @JsonKey(name: 'address_comment')
  final String addressComment;

  @JsonKey(name: 'address_id')
  final int addressId;

  /// ID карты, с которой оплачивается заказ
  @JsonKey(name: 'card_id')
  final String cardId;

  /// Дата доставки
  final String date;

  @JsonKey(name: 'payment_type')
  final PaymentTypeData paymentType;

  /// id временного интервала доставки
  final int time;

  Map<String, dynamic> toJson() => _$OrderUpdatingDataToJson(this);
}
