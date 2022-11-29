import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/domain/order/bonus.dart';
import 'package:uzhindoma/domain/order/delivery_date.dart';
import 'package:uzhindoma/domain/order/delivery_time_interval.dart';
import 'package:uzhindoma/domain/order/payment_type.dart';
import 'package:uzhindoma/domain/order/promocode.dart';
import 'package:uzhindoma/domain/payment/payment_card.dart';

/// Обертка над данными для заказа
class OrderWrapper {
  const OrderWrapper({
    this.deliveryDate,
    this.deliveryTimeInterval,
    this.name,
    this.phone,
    this.bonus,
    this.promoCode,
    this.paymentMethod,
    this.address,
    this.card,
    this.addressComment,
    this.isNoPaperRecipe,
    this.isPromo
  });

  /// Бонусы примененные к заказу
  final Bonus bonus;

  /// Промокод примененный к заказу
  final PromoCode promoCode;

  /// Метод полаты заказа
  final PaymentType paymentMethod;

  /// Карта пользователя
  final PaymentCard card;

  /// Адрес пользователя
  final UserAddress address;

  /// День доставки
  final DeliveryDate deliveryDate;

  /// Время доставки
  final DeliveryTimeInterval deliveryTimeInterval;

  /// Имя получателя (если доставка не себе)
  final String name;

  /// Телефон получателя
  final String phone;

  /// Комментарий к адресу
  final String addressComment;

  /// Нужны ли печатные рецепты
  final bool isNoPaperRecipe;

  /// Указывается если оформляется промо-набор
  final int isPromo;

  OrderWrapper copyWith({
    Bonus bonus,
    PromoCode promoCode,
    PaymentType paymentMethod,
    PaymentCard card,
    UserAddress address,
    DeliveryDate deliveryDate,
    DeliveryTimeInterval deliveryTimeInterval,
    String name,
    String phone,
    String addressComment,
    bool isNoPaperRecipe,
    int isPromo,
  }) {
    return OrderWrapper(
      bonus: bonus ?? this.bonus,
      promoCode: promoCode ?? this.promoCode,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      card: card ?? this.card,
      address: address ?? this.address,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryTimeInterval: deliveryTimeInterval ?? this.deliveryTimeInterval,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      addressComment: addressComment ?? this.addressComment,
      isNoPaperRecipe: isNoPaperRecipe ?? this.isNoPaperRecipe,
      isPromo: isPromo ?? this.isPromo,
    );
  }
}
