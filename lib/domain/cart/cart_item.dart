import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/cart/cart_element.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/util/const.dart';

/// Элемент корзины.
/// [id] - идентификатор элемента.
/// [name] - имя элемента.
/// [previewImg] - ссылка на изображение.
/// [price] - цена.
/// [discountPrice] - цена со скидкой.
/// [qty] - количество.
/// [ratio] - количество порций для добавления/удаления за раз.
/// [type] - тип блюда.
class CartItem implements CartElement {
  CartItem({
    @required this.id,
    @required this.name,
    @required this.previewImg,
    @required this.price,
    @required this.discountPrice,
    @required this.qty,
    @required this.ratio,
    @required this.type,
  })  : assert(id != null),
        assert(name != null),
        assert(previewImg != null),
        assert(price != null),
        assert(discountPrice != null),
        assert(qty != null),
        assert(ratio != null),
        assert(type != null);

  @override
  final String id;
  final String name;
  final String previewImg;
  final int price;
  final int discountPrice;
  final int qty;
  @override
  final int ratio;
  final MenuItemType type;

  String _priceTitle;
  String _discountPriceTitle;

  /// Цена со знаком рубля
  String get priceTitle {
    _priceTitle ??= '$price $rubSymbol';
    return _priceTitle;
  }

  /// Цена по скидке со знаком рубля
  String get discountPriceTitle {
    if (discountPrice == null || discountPrice == price) return null;
    _discountPriceTitle ??= '$discountPrice $rubSymbol';
    return _discountPriceTitle;
  }
}
