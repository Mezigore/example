import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/address/user_address.dart';
import 'package:uzhindoma/api/data/cart/extra_item_data.dart';
import 'package:uzhindoma/api/data/order/bought_item.dart';
import 'package:uzhindoma/api/data/order/change_conditions.dart';
import 'package:uzhindoma/api/data/order/order_status.dart';
import 'package:uzhindoma/api/data/order/order_summ.dart';
import 'package:uzhindoma/api/data/order/payment_type.dart';
import 'package:uzhindoma/api/data/order/time_interval.dart';

part 'new_order.g.dart';

/// Информация о новом заказе
@JsonSerializable()
class NewOrderData {
  NewOrderData({
    this.boughtExtraItems,
    this.boughtItems,
    this.canBeRestored,
    this.changeConditions,
    this.deliveryAddress,
    this.deliveryDate,
    this.deliveryTime,
    this.id,
    this.name,
    this.orderDate,
    this.orderSumm,
    this.weekId,
    this.paymentType,
    this.phone,
    this.status,
    this.noPaperRecipe,
  });

  factory NewOrderData.fromJson(Map<String, dynamic> json) {
  return _$NewOrderDataFromJson(json);
  }


  @JsonKey(name: 'bought_extra_items')
  final List<ExtraItemData> boughtExtraItems;

  @JsonKey(name: 'bought_items')
  final List<BoughtItemData> boughtItems;

  /// Можно ли восстановить заказ (для отмененных заказов)
  @JsonKey(name: 'can_be_restored')
  final bool canBeRestored;

  @JsonKey(name: 'change_conditions')
  final ChangeConditionsData changeConditions;

  @JsonKey(name: 'delivery_address')
  final UserAddressData deliveryAddress;

  /// Дата доставки в формате ISO 8601 "yyyy-MM-dd"
  @JsonKey(name: 'delivery_date')
  final String deliveryDate;

  @JsonKey(name: 'delivery_time')
  final TimeIntervalData deliveryTime;

  @JsonKey(name: 'week_id')
  final String weekId;

  /// id заказа
  final String id;

  /// Имя получателя в случае, если заказ оформлен на другого человека
  final String name;

  /// Дата заказа в формате ISO 8601 "yyyy-MM-dd"
  @JsonKey(name: 'order_date')
  final String orderDate;

  @JsonKey(name: 'order_summ')
  final OrderSummData orderSumm;

  @JsonKey(name: 'payment_type')
  final PaymentTypeData paymentType;

  @JsonKey(name: 'no_paper_reciре')
  final bool noPaperRecipe;

  /// Телефон получателя в случае, если заказ оформлен на другого человека
  final String phone;

  final OrderStatusData status;

  Map<String, dynamic> toJson() => _$NewOrderDataToJson(this);
}
