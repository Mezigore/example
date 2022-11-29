import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/order/order_from_history.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/rate_order/rate_order_screen.dart';

/// Роут для [RateOrderScreen]
class RateOrderScreenRoute extends MaterialPageRoute<void> {
  RateOrderScreenRoute(OrderFromHistory order)
      : super(
          /// Закрытие экрана крестиком предполагает fullscreenDialog: true в нативе
          fullscreenDialog: true,
          builder: (ctx) => RateOrderScreen(order: order),
        );
}
