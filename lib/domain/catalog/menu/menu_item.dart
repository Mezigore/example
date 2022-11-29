import 'package:flutter/material.dart' hide MenuItem;
import 'package:uzhindoma/domain/cart/cart_element.dart';
import 'package:uzhindoma/domain/catalog/menu/properties_menu_item.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/util/currency_formatter.dart';
import 'package:uzhindoma/util/enum.dart';

/// Модель конкретного блюда.
/// [id] - идентификатор блюда.
/// [name] - название блюда.
/// [previewImg] - ссылка на картинку для списка.
/// [detailImg] - ссылка на картинку для деталей.
/// [price] - цена за блюдо.
/// [promoPrice] - цена за 5 ужинов.
/// [measureUnit] - мера порционности.
/// [properties] - свойства блюда, см. [PropertiesMenuItem].
/// [type] - тип блюда, см. [MenuItemType].
/// [isAvailable] - доступно ли блюдо для заказа
class MenuItem implements CartElement {
  MenuItem({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.type,
    this.previewImg,
    this.detailImg,
    this.measureUnit,
    this.properties,
    this.isAvailable = true,
    this.promoPrice,
  })  : assert(id != null),
        assert(name != null),
        assert(price != null),
        assert(type != null);

  @override
  final String id;
  final String name;
  final String previewImg;
  final String detailImg;
  final int price;
  final int promoPrice;
  final String measureUnit;
  final PropertiesMenuItem properties;
  final MenuItemType type;
  final bool isAvailable;

  String _priceFormat;

  /// Форматированная цена с валютой
  String get priceUi {
    _priceFormat ??= '${currencyFormatter(price)}$rubleText';

    return _priceFormat;
  }

  @override
  int get ratio => properties?.ratio ?? 0;
}

/// Тип блюда.
class MenuItemType extends Enum<String> {
  const MenuItemType._(String value) : super(value);

  static const premium = MenuItemType._('premium');
  static const common = MenuItemType._('common');
  static const extra = MenuItemType._('extra');
}
