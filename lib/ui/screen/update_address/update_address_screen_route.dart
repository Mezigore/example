import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/ui/screen/update_address/update_address_screen.dart';

/// Роут для [UpdateAddressScreen]
class UpdateAddressScreenRoute extends MaterialPageRoute<void> {
  UpdateAddressScreenRoute(int addressId, NewAddress initAddress)
      : super(
          fullscreenDialog: true,
          builder: (ctx) => UpdateAddressScreen(
            addressId: addressId,
            initAddress: initAddress,
          ),
        );
}
