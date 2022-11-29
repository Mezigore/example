import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_route.dart';

// ignore: always_use_package_imports
import 'select_address_screen.dart';

/// Роут для [SelectAddressScreen]
class SelectAddressScreenRoute extends CreateOrderMaterialRoute<void> {
  SelectAddressScreenRoute({
    bool isForSelf,
  }) : super(
          builder: (ctx) => SelectAddressScreen(
            isForSelf: isForSelf ?? true,
          ),
        );
}
