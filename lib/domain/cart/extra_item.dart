import 'package:flutter/material.dart';
import 'package:uzhindoma/util/const.dart';

/// Подарочный товар в корзине.
/// [id] - идентификатор элемента.
/// [name] - имя элемента.
/// [previewImg] - ссылка на изображение.
/// [price] - цена.
class ExtraItem {
  ExtraItem({
    @required this.id,
    @required this.name,
    @required this.previewImg,
    @required this.price,
  })  : assert(id != null),
        assert(name != null),
        assert(previewImg != null),
        assert(price != null);

  final String id;
  final String name;
  final String previewImg;
  final int price;

  String _priceTitle;

  /// Цена со знаком рубля
  String get priceTitle {
    _priceTitle ??= '$price $rubSymbol';
    return _priceTitle;
  }
}
