import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/order/new_order.dart';

// ignore: always_use_package_imports
import 'new_order_info_screen.dart';

/// Роут для [NewOrderInfoScreen]
class NewOrderInfoScreenRoute extends MaterialPageRoute<void> {
  NewOrderInfoScreenRoute(NewOrder order)
      : super(
          builder: (ctx) => NewOrderInfoScreen(order: order),
        );
}
