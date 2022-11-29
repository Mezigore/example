import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_route.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/thanks/thanks_screen.dart';

/// Роут для [ThanksScreen]
class ThanksScreenRoute extends CreateOrderMaterialRoute<void> {
  // ignore: avoid_positional_boolean_parameters
  ThanksScreenRoute({bool isPayed, int ordersCount})
      : super(
          builder: (ctx) => ThanksScreen(
            isPayed: isPayed,
            ordersCount: ordersCount,
          ),
        );
}
