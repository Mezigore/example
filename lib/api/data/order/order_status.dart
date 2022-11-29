import 'package:json_annotation/json_annotation.dart';

/// Статус заказа:
/// Confirmed - Подтвержден
/// Paid - Оплачен
/// Canceled - Отменен
enum OrderStatusData {
  @JsonValue('Canceled')
  canceled,
  @JsonValue('Paid')
  paid,
  @JsonValue('Confirmed')
  confirmed,
}
