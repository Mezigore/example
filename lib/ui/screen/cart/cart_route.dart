import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/screen/cart/cart_screen.dart';

/// Route for [CartScreen]
class CartRoute extends MaterialPageRoute<void> {
  /// Просто обход ассерта от MaterialPageRoute
  CartRoute() : super(builder: (_) => const SizedBox());

  @override
  Widget buildContent(BuildContext context) => CartScreen(cartRoute: this);
}
