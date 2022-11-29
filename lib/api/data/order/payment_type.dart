import 'package:uzhindoma/ui/res/strings/strings.dart';

/// Способ оплаты -- Apple и Google Pay, картой, наличными
enum PaymentTypeData {
  card,
  cash,
  // pay,
}

extension PaymentTypeExt on PaymentTypeData {
  String get title {
    switch (this) {
      case PaymentTypeData.card:
        return paymentMethodCard;
      // case PaymentTypeData.pay:
      //   return Platform.isAndroid
      //       ? paymentMethodGooglePay
      //       : paymentMethodApplePay;
      case PaymentTypeData.cash:
        return paymentMethodCash;
      default:
        throw UnimplementedError('Undefined title for $this');
    }
  }
}
