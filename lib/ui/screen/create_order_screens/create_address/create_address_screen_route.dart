import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_route.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/create_address/create_order_address_screen.dart';

/// Роут для [CreateOrderAddressScreen]
class CreateOrderAddressScreenRoute
    extends CreateOrderMaterialRoute<UserAddress> {
  CreateOrderAddressScreenRoute({bool canGoBack})
      : super(
          builder: (ctx) => CreateOrderAddressScreen(canGoBack: canGoBack),
        );
}
