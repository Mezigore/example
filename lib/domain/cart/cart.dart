import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/cart/cart_item.dart';
import 'package:uzhindoma/domain/cart/discount_condition.dart';
import 'package:uzhindoma/domain/cart/extra_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/domain/catalog/menu/recommendation_item.dart';
import 'package:uzhindoma/domain/catalog/week_item.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/util/const.dart';
import 'package:uzhindoma/util/currency_formatter.dart';

/// Модель пользовательской корзины.
/// [minCount] - минимальное количество блюд для заказа.
/// [discount] - скидка пользователя в процентах.
/// [discountConditions] - набор условий получения скидок см [DiscountCondition].
/// [price] - Общая цена.
/// [discountPrice] - Общая цена со скидкой.
/// [menu] - список элементов в корзине, см [CartItem].
/// [discountSumm] - скидка пользователя в рублях Ужин Дома Family.
/// [discountCountSumm] - скидка за N блюд в рублях.
/// [totalPrice] - полная сумма без скидок за количество.
class Cart {
  Cart({
    @required this.minCount,
    @required this.minPrice,
    @required this.discount,
    @required this.discountSumm,
    @required this.discountCountSumm,
    @required this.discountConditions,
    @required this.price,
    @required this.totalPrice,
    @required this.discountPrice,
    @required this.menu,
    this.weekItem,
    this.extraItems,
    this.recommendationItem,
    this.promoname,
  })  : assert(minCount != null),
        assert(minPrice != null),
        assert(discount != null),
        assert(discountSumm != null),
        assert(discountConditions != null),
        assert(price != null),
        assert(totalPrice != null),
        assert(discountPrice != null),
        assert(menu != null);

  final int minCount;
  final int minPrice;
  final int discount;
  final int discountSumm;
  final int discountCountSumm;
  final List<DiscountCondition> discountConditions;
  final int price;
  final int totalPrice;
  final int discountPrice;
  final WeekItem weekItem;
  final List<CartItem> menu;
  final List<ExtraItem> extraItems;
  final RecommendationItem recommendationItem;
  final String promoname;

  Cart copyWith({
    RecommendationItem recommendationItem,
    int totalPrice,
    int discountPrice,
    int discountSumm,
    List<CartItem> menu,
    int discountCountSumm,
    List<DiscountCondition> discountConditions,
    int price,
    int discount,
    int minPrice,
    int minCount,
    WeekItem weekItem,
    List<ExtraItem> extraItems,
    String promoname,
  }) =>
      Cart(
        recommendationItem: recommendationItem ?? this.recommendationItem,
        totalPrice: totalPrice ?? this.totalPrice,
        discountPrice: discountPrice ?? this.discountPrice,
        discountSumm: discountSumm ?? this.discountSumm,
        menu: menu ?? this.menu,
        discountCountSumm: discountCountSumm ?? this.discountCountSumm,
        discountConditions: discountConditions ?? this.discountConditions,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        minPrice: minPrice ?? this.minPrice,
        minCount: minCount ?? this.minCount,
        weekItem: weekItem ?? this.weekItem,
        extraItems: extraItems ?? this.extraItems,
        promoname: promoname ?? this.promoname,
      );

  /// Кешируем чтобы постянно не форматировать - данные
  /// не поменяются для этой корзины
  String _discountPriceText;
  String _discountSummText;
  String _discountCountSummText;
  String _priceText;
  String _totalPriceText;
  String _countText;
  String _countDinnersText;
  String _hintText;
  String _discountText;
  bool _canCreateOrder;
  List<CartItem> _commonDishes;
  int _currentCount;
  int _maxCount;
  RecommendationItem _recommendationItem;

  String get discountText {
    if (discount == null || discount <= 0) return '0';
    _discountText ??= '−$discountSumm $rubSymbol ($discount %)';
    return _discountText;
  }

  /// скидка Ужин Дома Family в рублях
  String get discountSummText {
    if (discountSumm == null || discountSumm <= 0) return null;
    _discountSummText ??= '−$discountSumm $rubSymbol';
    return _discountSummText;
  }

  /// Скидка за 4 / 5 ужинов в рублях
  String get discountCountSummText {
    if (discountCountSumm == null || discountCountSumm <= 0) return null;
    _discountCountSummText ??= '−$discountCountSumm $rubSymbol';
    return _discountCountSummText;
  }

  int get maxCount {
    _maxCount ??= discountConditions
            ?.reduce((value, element) =>
                value.count > element.count ? value : element)
            ?.count ??
        minCount;
    return _maxCount;
  }

  int get currentCount {
    _currentCount ??= commonDishes.length;
    return _currentCount;
  }

  List<CartItem> get commonDishes {
    _commonDishes ??=
        menu.where((element) => element.type != MenuItemType.extra).toList();
    return _commonDishes;
  }

  bool get canCreateOrder {
    // _canCreateOrder ??= minCount <= currentCount;
    _canCreateOrder ??= minPrice <= totalPrice;
    return _canCreateOrder;
  }

  /// Текст для отображения цены
  String get discountPriceText {
    _discountPriceText ??= '${currencyFormatter(discountPrice)} $rubleText';
    return _discountPriceText;
  }

  /// Текст для отображения цены без скидки
  String get priceText {
    _priceText ??= '${currencyFormatter(price)} $rubleText';
    return _priceText;
  }

  /// Текст для отображения цены без скидки
  String get totalPriceText {
    _totalPriceText ??= '${currencyFormatter(totalPrice)} $rubleText';
    return _totalPriceText;
  }

  /// Есть ли выгода
  bool get hasDiscount => totalPrice != discountPrice;

  /// Текст для отображения количества блюд - блюдо
  String get countText {
    _countText ??= '${menu.length} ${dishesPlural(menu.length)}';
    return _countText;
  }

  /// Текст для отображения количества блюд - 4 ужина
  String get countDinnersText {
    _countDinnersText ??= '${menu.length} ${mainDishesPlural(menu.length)}';
    return _countDinnersText;
  }

  /// Текст подсказки
  String get hintText {
    if (_hintText == null) {
      // if (currentCount < minCount) {
      if (totalPrice < minPrice) {
        // _hintText = getHintToAvailable(minCount - currentCount);
        _hintText = getHintToAvailable(minPrice: minPrice, deltaPrice: minPrice - totalPrice);
      } else if (discountConditions.isNotEmpty) {
        DiscountCondition nearestDiscount;
        for (final dis in discountConditions) {
          if (dis.count > currentCount) {
            if (nearestDiscount != null) {
              nearestDiscount =
                  nearestDiscount.count < dis.count ? nearestDiscount : dis;
            } else {
              nearestDiscount = dis;
            }
          }
        }

        if (nearestDiscount != null) {
          _hintText = getHintToDiscount(
            nearestDiscount.count - currentCount,
            nearestDiscount.discount,
          );
        }
      } else {
        _hintText = emptyString;
      }
    }

    return _hintText;
  }
}
