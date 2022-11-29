import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/screen/create_address/create_address_screen.dart';

/// Роут для [CreateAddressScreen]
class CreateAddressScreenRoute extends MaterialPageRoute<void> {
  CreateAddressScreenRoute()
      : super(
          fullscreenDialog: true,
          builder: (ctx) => CreateAddressScreen(),
        );
}
