import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/domain/cart/extra_item.dart';
import 'package:uzhindoma/domain/order/bought_item.dart';
import 'package:uzhindoma/domain/order/change_conditions.dart';
import 'package:uzhindoma/domain/order/order_status.dart';
import 'package:uzhindoma/domain/order/order_summ.dart';
import 'package:uzhindoma/domain/order/payment_type.dart';
import 'package:uzhindoma/domain/order/time_interval.dart';
import 'package:uzhindoma/util/const.dart';
import 'package:uzhindoma/util/date_formatter.dart';

/// Информация о новом заказе
class NewOrder {
  NewOrder({
    this.id,
    this.boughtExtraItems,
    this.boughtItems,
    this.canBeRestored,
    this.changeConditions,
    this.deliveryAddress,
    this.deliveryDate,
    this.deliveryTime,
    this.name,
    this.orderDate,
    this.orderSumm,
    this.paymentType,
    this.phone,
    this.status,
    this.weekId,
    this.noPaperRecipe,
  });

  final List<ExtraItem> boughtExtraItems;
  final List<BoughtItem> boughtItems;

  final String weekId;

  /// Можно ли восстановить заказ (для отмененных заказов)
  final bool canBeRestored;

  final ChangeConditions changeConditions;

  final UserAddress deliveryAddress;

  /// Дата доставки
  final DateTime deliveryDate;

  final TimeInterval deliveryTime;

  /// id заказа
  final String id;

  /// Имя получателя в случае, если заказ оформлен на другого человека
  final String name;

  /// Дата заказа
  final DateTime orderDate;

  final OrderSum orderSumm;

  final PaymentType paymentType;

  final bool noPaperRecipe;

  /// Телефон получателя в случае, если заказ оформлен на другого человека
  final String phone;

  final OrderStatus status;

  String _orderDateTitle;
  String _deliveryDateTitle;
  String _orderNumberTitle;

  String get orderDateTitle {
    _orderDateTitle ??= 'от ${DateUtil.formatToDate(orderDate)}';
    return _orderDateTitle;
  }

  String get deliveryDateTitle {
    if (deliveryDate == null) return emptyString;
    _deliveryDateTitle ??= DateUtil.formatDayWeekDayMonth(deliveryDate);
    return _deliveryDateTitle;
  }

  String get orderNumberTitle {
    _orderNumberTitle ??= '№ $id';
    return _orderNumberTitle;
  }
}
