import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/order/payment_type.dart';

part 'created_order.g.dart';

/// Модель для создания заказа
@JsonSerializable()
class CreatedOrderData {
  CreatedOrderData({
    this.addressId,
    this.addressComment,
    this.bonusAmount,
    this.cardId,
    this.date,
    this.name,
    this.paymentType,
    this.phone,
    this.promoCode,
    this.time,
    this.isNoPaperRecipe,
    this.isPromo,
  });

  factory CreatedOrderData.fromJson(Map<String, dynamic> json) =>
      _$CreatedOrderDataFromJson(json);

  @JsonKey(name: 'address_id')
  final int addressId;

  @JsonKey(name: 'address_comment')
  final String addressComment;

  /// Количество бонусов, которые можно списать
  @JsonKey(name: 'bonus_amount')
  final int bonusAmount;

  /// ID карты, с которой оплачивается заказ
  @JsonKey(name: 'card_id')
  final String cardId;

  /// Дата доставки
  final String date;

  /// Имя получателя в случае, если заказ оформлен на другого человека
  final String name;

  /// способ оплаты -- Apple и Google Pay, картой, наличными
  @JsonKey(name: 'payment_type')
  final PaymentTypeData paymentType;

  /// Телефон получателя в случае, если заказ оформлен на другого человека
  final String phone;

  @JsonKey(name: 'promocode')
  final String promoCode;

  /// id временного интервала доставки
  final int time;

  /// Нужны ли печатные рецепты
  @JsonKey(name: 'no_paper_reciре')
  final bool isNoPaperRecipe;

 /// Промо-набор
  @JsonKey(name: 'is_promo')
  final int isPromo;

  Map<String, dynamic> toJson() => _$CreatedOrderDataToJson(this);
}
