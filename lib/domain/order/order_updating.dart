import 'package:uzhindoma/domain/order/payment_type.dart';

/// Изменение заказа
class OrderUpdating {
  OrderUpdating({
    this.addressComment,
    this.addressId,
    this.cardId,
    this.date,
    this.paymentType,
    this.time,
  });

  /// Комментарий к адресу
  final String addressComment;

  final int addressId;

  /// ID карты, с которой оплачивается заказ
  final String cardId;

  /// Дата доставки
  final String date;

  final PaymentType paymentType;

  /// id временного интервала доставки
  final int time;
}
