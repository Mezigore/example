import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/domain/order/order_change_enum.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/change_order/change_order_screen.dart';

/// Роут для [ChangeOrderScreen]
class ChangeOrderScreenRoute extends MaterialPageRoute<bool> {
  ChangeOrderScreenRoute(
    OrderChanges change,
    NewOrder order,
  ) : super(
          builder: (ctx) => ChangeOrderScreen(
            change: change,
            order: order,
          ),
        );
}
