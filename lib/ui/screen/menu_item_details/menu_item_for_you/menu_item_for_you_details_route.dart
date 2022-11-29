import 'package:flutter/material.dart' hide MenuItem;
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';

import 'menu_item_for_you_details_screen.dart';

/// Route for [MenuItemForYouDetailsScreen]
class MenuItemForYouDetailsRoute extends MaterialPageRoute<void> {
  MenuItemForYouDetailsRoute({
    Key key,
    @required List<CategoryItem> listCategoryItem,
    @required MenuItem menuItem,
  })  : assert(listCategoryItem != null && listCategoryItem.isNotEmpty),
        assert(menuItem != null),
        super(
        builder: (ctx) => MenuItemForYouDetailsScreen(
          key: key,
          listCategoryItem: listCategoryItem,
          menuItem: menuItem,
        ),
      );
}