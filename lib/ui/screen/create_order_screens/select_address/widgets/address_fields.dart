import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/widget/address/address_tile.dart';

/// Полу с выбором адреса и отображением комментария
class AddressFields extends StatelessWidget {
  const AddressFields({
    Key key,
    this.address,
    this.onAddressPressed,
    this.commentController,
  }) : super(key: key);

  final TextEditingController commentController;
  final UserAddress address;
  final VoidCallback onAddressPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(12.0),
          color: textFormFieldFillColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onAddressPressed,
            child: AddressTile(
              address: address,
              needFullAddress: true,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: commentController,
          maxLines: 2,
          minLines: 1,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: createOrderAddressComment,
            contentPadding: EdgeInsets.fromLTRB(16, 9, 16, 14),
          ),
        ),
      ],
    );
  }
}
