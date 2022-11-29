import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/util/const.dart';

/// Что изменить в заказе
enum OrderChanges {
  /// изменить адрес доставки
  changeAddress,

  /// изменить дату и время доставки
  changeDeliveryDate,

  /// изменить способ оплаты
  changePaymentType,
}

extension OrderChangesExt on OrderChanges {
  /// Заголовок
  String get title {
    switch (this) {
      case OrderChanges.changeAddress:
        return orderChangeAddress;
      case OrderChanges.changeDeliveryDate:
        return orderChangeDeliveryTime;
      case OrderChanges.changePaymentType:
        return orderChangePayment;
    }
    return emptyString;
  }
}
