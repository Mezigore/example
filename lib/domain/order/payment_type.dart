import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';

/// Способ оплаты -- Apple и Google Pay, картой, наличными
enum PaymentType {
  card,
  cash,
  // pay,
}

extension PaymentTypeExt on PaymentType {
  /// Заголовок
  String get title {
    switch (this) {
      case PaymentType.card:
        return paymentMethodCard;
      // case PaymentType.pay:
      //   return Platform.isAndroid
      //       ? paymentMethodGooglePay
      //       : paymentMethodApplePay;
      case PaymentType.cash:
        return paymentMethodCash;
      default:
        throw EnumArgumentException('Not found PaymentTypeData for $this');
    }
  }
}
