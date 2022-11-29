import 'package:uzhindoma/ui/res/strings/strings.dart';

/// Статус заказа:
/// confirmed - Подтвержден
/// paid - Оплачен
/// canceled - Отменен
enum OrderStatus {
  canceled,
  paid,
  confirmed,
}

extension OrderStatusExt on OrderStatus {
  /// Заголовок для бейджа
  String get title {
    switch (this) {
      case OrderStatus.canceled:
        return orderCanceled;
      case OrderStatus.paid:
        return orderPaid;
      case OrderStatus.confirmed:
        return orderConfirmed;
    }
    return '';
  }
}
