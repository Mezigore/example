import 'package:uzhindoma/api/data/order/payment_type.dart';
import 'package:uzhindoma/domain/order/order_wrapper.dart';
import 'package:uzhindoma/interactor/order/order_repository/order_mappers.dart';

/// Модель для создания заказа
class CreatedOrder {
  const CreatedOrder({
    this.addressId,
    this.bonusAmount,
    this.cardId,
    this.date,
    this.name,
    this.paymentType,
    this.phone,
    this.promoCode,
    this.time,
    this.addressComment,
    this.isNoPaperRecipe,
    this.isPromo,
  });

  factory CreatedOrder.fromOrderWrapper(OrderWrapper wrap) {
    return CreatedOrder(
      addressId: wrap.address.id,
      addressComment: wrap.addressComment,
      bonusAmount: wrap.bonus?.bonusAmount,
      cardId: wrap.card?.id,
      date: wrap.deliveryDate.date,
      name: wrap.name,
      paymentType: mapPaymentTypeData(wrap.paymentMethod),
      phone: wrap.phone,
      promoCode: wrap.promoCode?.promoCode.toString(),
      time: wrap.deliveryTimeInterval?.id,
      isNoPaperRecipe: wrap.isNoPaperRecipe,
      isPromo: wrap.isPromo,
    );
  }

  final int addressId;

  /// Комментарий к адресу
  final String addressComment;

  /// Количество бонусов, которые можно списать
  final int bonusAmount;

  /// ID карты, с которой оплачивается заказ
  final String cardId;

  /// Дата доставки
  final String date;

  /// Имя получателя в случае, если заказ оформлен на другого человека
  final String name;

  /// способ оплаты -- Apple и Google Pay, картой, наличными
  final PaymentTypeData paymentType;

  /// Телефон получателя в случае, если заказ оформлен на другого человека
  final String phone;

  final String promoCode;

  /// id временного интервала доставки
  final int time;

  /// Нужны ли печатные рецепты
  final bool isNoPaperRecipe;

  /// Указывается если оформляется промо-набор
  final int isPromo;

}
