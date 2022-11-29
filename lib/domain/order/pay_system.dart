import 'package:uzhindoma/api/data/order/payment_system.dart';

class PaySystem {
  PaySystem({
    this.paySystem,
    this.paymentToken,
  });

  /// Платежная система
  final PaymentSystem paySystem;

  /// Токен для оплаты через Google Pay и Apple Pay
  final String paymentToken;
}
