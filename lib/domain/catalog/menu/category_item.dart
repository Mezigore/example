import 'package:flutter/material.dart' hide MenuItem;
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';

/// Категория меню.
/// [id] - идентификатор категории.
/// [code] - код категории.
/// [name] - имя категории.
/// [showCategoryName] - нужно ли показывать имя категории.
/// [count] - общее количество товаров в категории.
/// [products] - массив продуктов.
/// [description] - описание перед категорией.
/// [iconUrl] - иконка для описания.
/// [isBigCards] - тип карточек товаров.
class CategoryItem {
  CategoryItem({
    @required this.id,
    @required this.code,
    @required this.name,
    @required this.showCategoryName,
    @required this.products,
    this.count,
    this.description,
    this.iconUrl,
    this.isBigCards,
  })  : assert(id != null || code == codeOutOfStock || code == codeForYou),
        assert(code != null),
        assert(name != null || code == codeOutOfStock || code == codeForYou),
        assert(products != null);

  CategoryItem.copy(
    CategoryItem item, {
    String id,
    String code,
    String name,
    int count,
    List<MenuItem> products,
    String description,
    String iconUrl,
    bool showCategoryName,
    int isBigCards,
  })  : id = id ?? item.id,
        code = code ?? item.code,
        name = name ?? item.name,
        count = count ?? item.count,
        products = products ?? item.products,
        description = description ?? item.description,
        iconUrl = iconUrl ?? item.iconUrl,
        showCategoryName = showCategoryName ?? item.showCategoryName,
        isBigCards = isBigCards ?? item.isBigCards;

  static const String codeOutOfStock = 'outofstock';
  static const String codeForYou = 'foryou';

  final String id;
  final String code;
  final String name;
  final int count;
  final List<MenuItem> products;
  final String description;
  final String iconUrl;
  final bool showCategoryName;
  final int isBigCards;
}

/// Специальная категория только для блюд которые закончились.
class OutOfStockCategory extends CategoryItem {
  OutOfStockCategory(CategoryItem categoryItem) : super.copy(categoryItem);
}