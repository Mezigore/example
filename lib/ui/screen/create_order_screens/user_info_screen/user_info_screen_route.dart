import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_route.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/user_info_screen/user_info_screen.dart';

/// Роут для [UserInfoScreen]
class UserInfoScreenRoute extends CreateOrderMaterialRoute<void> {
  UserInfoScreenRoute() : super(builder: (ctx) => UserInfoScreen());
}
