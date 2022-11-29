import 'package:flutter/material.dart' hide MenuItem;
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/ui/screen/cart/screens/cart_item_info/cart_item_info_screen.dart';

/// Роут для [CartItemInfoScreen]
class CartItemInfoScreenRoute extends MaterialPageRoute<void> {
  CartItemInfoScreenRoute(MenuItem item)
      : super(
          builder: (ctx) => CartItemInfoScreen(
            item: item,
          ),
        );
}
