import 'package:flutter/material.dart' hide MenuItem;
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/domain/catalog/menu/promo_params.dart';

/// Промо набор.
/// [id] - идентификатор категории.
/// [code] - код категории.
/// [name] - имя категории.
/// [showCategoryName] - нужно ли показывать имя категории.
/// [count] - общее количество товаров в категории.
/// [products] - массив продуктов.
/// [description] - описание перед категорией.
/// [iconUrl] - иконка для описания.
/// [params] - параметры промо набора.
class PromoItem {
  PromoItem({
    @required this.id,
    @required this.code,
    @required this.name,
    @required this.showCategoryName,
    @required this.products,
    @required this.params,
    @required this.appTitle,
    @required this.appDescription,
    this.count,
    this.description,
    this.iconUrl,
  })  : assert(id != null),
        assert(code != null),
        assert(name != null),
        assert(params != null),
        assert(appTitle != null),
        assert(appDescription != null),
        assert(products != null);

  PromoItem.copy(
      PromoItem item, {
        String id,
        String code,
        String name,
        int count,
        List<MenuItem> products,
        String description,
        String appTitle,
        String appDescription,
        String iconUrl,
        bool showCategoryName,
        PromoParams params,
      })  : id = id ?? item.id,
        code = code ?? item.code,
        name = name ?? item.name,
        count = count ?? item.count,
        products = products ?? item.products,
        description = description ?? item.description,
        appTitle = appTitle ?? item.appTitle,
        appDescription = appDescription ?? item.appDescription,
        iconUrl = iconUrl ?? item.iconUrl,
        params = params ?? item.params,
        showCategoryName = showCategoryName ?? item.showCategoryName;

  final String id;
  final String code;
  final String name;
  final int count;
  final List<MenuItem> products;
  final String description;
  final String iconUrl;
  final String appTitle;
  final String appDescription;
  final bool showCategoryName;
  final PromoParams params;
}