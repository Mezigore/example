import 'package:flutter/material.dart' hide MenuItem;
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/ui/screen/menu_item_details/menu_item_details_screen.dart';

/// Route for [MenuItemDetailsScreen]
class MenuItemDetailsRoute extends MaterialPageRoute<void> {
  MenuItemDetailsRoute({
    Key key,
    @required List<CategoryItem> listCategoryItem,
    @required MenuItem menuItem,
  })  : assert(listCategoryItem != null && listCategoryItem.isNotEmpty),
        assert(menuItem != null),
        super(
          builder: (ctx) => MenuItemDetailsScreen(
            key: key,
            listCategoryItem: listCategoryItem,
            menuItem: menuItem,
          ),
        );
}
