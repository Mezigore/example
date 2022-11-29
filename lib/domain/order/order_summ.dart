import 'package:uzhindoma/util/const.dart';

/// Стоимость заказа
class OrderSum {
  OrderSum({
    this.bonuses,
    this.discount,
    this.discountPrice,
    this.discountSum,
    this.sumId,
    this.price,
    this.totalPrice,
    this.discountCountSumm,
    this.promoCode,
  });

  /// Скидка в рублях за счет списания бонусов
  final int bonuses;

  /// Скидка пользователя в процентах
  final int discount;

  /// Скидка пользователя в рублях
  final int discountSum;

  /// Скидка от количества блюд пользователя в рублях
  final int discountCountSumm;

  /// Id объекта, который содержит стоимость заказа
  final int sumId;

  /// Общая цена заказа
  final int price;

  /// Общая цена заказа до вычета скидок
  final int totalPrice;

  /// Общая цена заказа со скидкой
  final int discountPrice;

  /// Скидка в рублях за счет применения промокода
  final int promoCode;

  String _discountTitle;
  String _discountSummTitle;
  String _discountCountTitle;
  String _priceTitle;
  String _totalPriceTitle;
  String _priceWithDiscountTitle;
  String _bonusTitle;
  String _promoCodeTitle;

  String get discountTitle {
    if (discountSum == null ||
        discountSum == 0 ||
        discount == null ||
        discount == 0) return null;
    _discountTitle ??= '−$discountSum $rubSymbol ($discount %)';
    return _discountTitle;
  }

  /// Тоже что и предыдущее, только без процентов Ужин дома
  String get discountSummTitle {
    if (discountSum == null || discountSum == 0) return null;
    _discountSummTitle ??= '−$discountSum $rubSymbol';
    return _discountSummTitle;
  }

  String get fullPriceTitle {
    _priceTitle ??= '$price $rubSymbol';
    return _priceTitle;
  }

  String get totalPriceTitle {
    _totalPriceTitle ??= '$totalPrice $rubSymbol';
    return _totalPriceTitle;
  }

  String get promoCodeTitle {
    if (promoCode == null || promoCode == 0) return null;
    _promoCodeTitle ??= '-$promoCode $rubSymbol';
    return _promoCodeTitle;
  }

  String get bonusTitle {
    if (bonuses == null || bonuses == 0) return null;
    _bonusTitle ??= '-$bonuses $rubSymbol';
    return _bonusTitle;
  }

  String get priceWithDiscountTitle {
    _priceWithDiscountTitle ??= '$discountPrice $rubSymbol';
    return _priceWithDiscountTitle;
  }

  /// За количество ужинов в рублях
  String get discountCountTitle {
    if (discountCountSumm == null || discountCountSumm == 0) return null;
    _discountCountTitle ??= '-$discountCountSumm $rubSymbol';
    return _discountCountTitle;
  }
}
