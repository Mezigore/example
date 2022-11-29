import 'package:flutter/material.dart' hide MenuItem;
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';

class RecommendationItem {
  RecommendationItem({
    @required this.title,
    @required this.products,
  })  : assert(title != null),
        assert(products != null);

  RecommendationItem.copy(
    RecommendationItem item, {
    String title,
    List<MenuItem> products,
  })  : title = title ?? item.title,
        products = products ?? item.products;

  final String title;
  final List<MenuItem> products;
}
