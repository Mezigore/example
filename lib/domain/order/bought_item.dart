import 'package:uzhindoma/util/const.dart';

/// Купленный товар в составе заказа
class BoughtItem {
  BoughtItem({
    this.discountPrice,
    this.id,
    this.name,
    this.previewImg,
    this.price,
  });

  /// Цена со скидкой за купленный товар
  final int discountPrice;

  final String id;

  final String name;

  /// Ссылка на картинку для списка
  final String previewImg;

  /// Цена за купленный товар
  final int price;

  String _priceTitle;
  String _discountPriceTitle;

  /// Цена со знаком рубля
  String get priceTitle {
    _priceTitle ??= '$price $rubSymbol';
    return _priceTitle;
  }

  /// Цена по скидке со знаком рубля
  String get discountPriceTitle {
    if (discountPrice == null) return null;
    _discountPriceTitle ??= '$discountPrice $rubSymbol';
    return _discountPriceTitle;
  }
}
