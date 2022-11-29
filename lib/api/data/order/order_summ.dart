import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/common/key_value_data.dart';

part 'order_summ.g.dart';

/// Стоимость заказа
@JsonSerializable()
class OrderSummData {
  OrderSummData({
    this.summId,
    this.discount,
    this.discountSumm,
    this.discountCountSumm,
    this.discountConditions,
    this.bonuses,
    this.promocode,
    this.totalPrice,
    this.price,
    this.discountPrice,
  });

  factory OrderSummData.fromJson(Map<String, dynamic> json) =>
      _$OrderSummDataFromJson(json);

  /// Id объекта, который содержит стоимость заказа
  @JsonKey(name: 'summ_id')
  final int summId;

  /// Скидка пользователя в процентах
  final int discount;

  /// Скидка пользователя в рублях
  @JsonKey(name: 'discount_summ')
  final int discountSumm;

  /// Скидка от количества блюд пользователя в рублях
  @JsonKey(name: 'discount_count_summ')
  final int discountCountSumm;

  /// Скидка от количества блюд пользователя в рублях
  @JsonKey(name: 'discount_conditions')
  final List<KeyValueData> discountConditions;

  /// Скидка в рублях за счет списания бонусов
  final int bonuses;

  /// Скидка в рублях за счет применения промокода
  final int promocode;

  /// Общая цена заказа до вычета скидок
  @JsonKey(name: 'total_price')
  final int totalPrice;

  /// Общая цена с учетом скидки за количество
  final int price;

  /// Общая цена заказа со скидкой
  @JsonKey(name: 'discount_price')
  final int discountPrice;

  Map<String, dynamic> toJson() => _$OrderSummDataToJson(this);
}
