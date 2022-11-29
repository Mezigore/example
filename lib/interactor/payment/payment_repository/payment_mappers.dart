import 'package:uzhindoma/api/data/payment/payment_card.dart';
import 'package:uzhindoma/domain/payment/payment_card.dart';

PaymentCard mapPaymentCard(PaymentCardData data) {
  return PaymentCard(
    id: data.id,
    name: data.name,
    isDefault: data.isDefault,
  );
}
