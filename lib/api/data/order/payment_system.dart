import 'package:uzhindoma/interactor/common/exceptions.dart';

/// Система оплаты
enum PaymentSystem {
  googlePay,
  applePay,
}

extension PaymentSystemExt on PaymentSystem {
  String get json {
    switch (this) {
      case PaymentSystem.googlePay:
        return 'google_pay';
      case PaymentSystem.applePay:
        return 'apple_pay';
      default:
        throw EnumArgumentException('Undefined json for $this');
    }
  }
}
