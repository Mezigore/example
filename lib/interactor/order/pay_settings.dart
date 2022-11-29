import 'package:mad_pay/mad_pay.dart';

class PaySettings {
  /// Google Pay
  static const _gatewayName = 'cloudpayments';
  static const _gatewayMerchantId = 'pk_e2197a23ad59a68fb2ebde3fa8cc1';

  static final _googleProd = GoogleParameters(
    gatewayName: _gatewayName,
    gatewayMerchantId: _gatewayMerchantId,
    emailRequired: false,
  );

  /// Apple Pay
  static const _merchantIdentifier = 'merchant.ru.app.uzhindoma';

  /// Настройки оплаты Google Pay
  static GoogleParameters get googleParameters => _googleProd;

  /// Настройки оплаты Apple Pay
  static final appleParameters = AppleParameters(
    merchantIdentifier: _merchantIdentifier,
  );

  /// Разрешенные карты
  static final allowedNetworks = [
    PaymentNetwork.mastercard,
    PaymentNetwork.visa,
  ];
}
