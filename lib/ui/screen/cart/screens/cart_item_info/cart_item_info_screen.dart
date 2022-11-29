import 'package:flutter/material.dart' hide MenuItem;
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/screen/product_details/product_details_screen.dart';

/// Экран отображения информации о товаре в корзине
class CartItemInfoScreen extends StatefulWidget {
  const CartItemInfoScreen({Key key, this.item}) : super(key: key);
  final MenuItem item;

  @override
  State<StatefulWidget> createState() => _CartItemInfoScreenState();
}

class _CartItemInfoScreenState extends State<CartItemInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        leadingIcon: Icons.close,
      ),
      body: ProductDetailsScreen(menuItem: widget.item),
    );
  }
}
