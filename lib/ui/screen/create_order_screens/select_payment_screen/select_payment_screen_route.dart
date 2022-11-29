import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_route.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/select_payment_screen.dart';

/// Роут для [SelectPaymentScreen]
class SelectPaymentScreenRoute extends CreateOrderMaterialRoute<void> {
  SelectPaymentScreenRoute()
      : super(
          builder: (ctx) => SelectPaymentScreen(),
          fullscreenDialog: false,
        );
}
