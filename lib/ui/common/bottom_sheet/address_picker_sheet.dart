import 'package:flutter/material.dart';
import 'package:surf_util/surf_util.dart';
import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/common/widgets/radio.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Шторка выбора адреса
class AddressPickerSheet extends StatelessWidget {
  const AddressPickerSheet({
    Key key,
    this.currentAddress,
    this.addresses,
  }) : super(key: key);

  /// Выбранный адрес
  final UserAddress currentAddress;

  /// Возможные адреса для выбора
  final List<UserAddress> addresses;

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 20,
              ),
              child: Text(
                dialogSelectAddressTitle,
                style: textMedium16,
              ),
            ),
            ...addresses
                .map(
                  (address) => _AddressSheetTile(
                    address: address,
                    isSelected: address.id == currentAddress?.id,
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

class _AddressSheetTile extends StatelessWidget {
  const _AddressSheetTile({
    Key key,
    this.address,
    this.isSelected = false,
  }) : super(key: key);

  final UserAddress address;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(address),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleRadio(isSelected: isSelected),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    address.fullName ?? address.name ?? emptyString,
                    style: textRegular16,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    address.cityName ?? emptyString,
                    style: textRegular14Secondary,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
