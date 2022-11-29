import 'package:uzhindoma/domain/order/order_change_enum.dart';

/// Параметры в заказе, которые можно изменить
class ChangeConditions {
  ChangeConditions({
    this.canChangeAddress,
    this.canChangeDeliveryDate,
    this.canChangePaymentType,
  });

  /// Можно ли изменить адрес доставки
  final bool canChangeAddress;

  /// Можно ли изменить дату и время доставки
  final bool canChangeDeliveryDate;

  /// Можно ли изменить способ оплаты
  final bool canChangePaymentType;

  List<OrderChanges> _changesList;

  List<OrderChanges> get changesList {
    _changesList ??= [
      if (canChangeDeliveryDate) OrderChanges.changeDeliveryDate,
      if (canChangeAddress) OrderChanges.changeAddress,
      if (canChangePaymentType) OrderChanges.changePaymentType,
    ];
    return _changesList;
  }
}
