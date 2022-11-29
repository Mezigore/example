import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_route.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_delivery_date/select_delivery_date_screen.dart';

/// Роут для [SelectDeliveryDateScreen]
class SelectDeliveryDateScreenRoute extends CreateOrderMaterialRoute<void> {
  SelectDeliveryDateScreenRoute()
      : super(
          builder: (ctx) => SelectDeliveryDateScreen(),
          fullscreenDialog: false,
        );
}
