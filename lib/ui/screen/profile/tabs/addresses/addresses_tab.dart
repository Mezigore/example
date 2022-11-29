import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/profile/tabs/addresses/addresses_tab_wm.dart';
import 'package:uzhindoma/ui/screen/profile/tabs/addresses/di/addresses_tab_component.dart';
import 'package:uzhindoma/ui/widget/address/address_tile.dart';
import 'package:uzhindoma/ui/widget/address/address_tile_placeholder.dart';
import 'package:uzhindoma/ui/widget/address_form/address_form.dart';
import 'package:uzhindoma/ui/widget/error/error.dart';

/// Таб с адресами
class AddressesTab extends MwwmWidget<AddressesTabComponent> {
  AddressesTab({Key key})
      : super(
          widgetModelBuilder: createAddressesTabWidgetModel,
          dependenciesBuilder: (context) => AddressesTabComponent(context),
          widgetStateBuilder: () => _AddressesTabState(),
          key: key,
        );
}

class _AddressesTabState extends WidgetState<AddressesTabWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: EntityStateBuilder<List<UserAddress>>(
        streamedState: wm.addressesListState,
        errorChild: ErrorStateWidget(onReloadAction: wm.reloadAction),
        loadingChild: _LoadingPlaceholder(),
        child: (_, addresses) {
          if (addresses == null || addresses.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Title(title: addressesDefault, needDivider: false),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AddressForm(
                      onAddressAccepted: wm.firstAddressAccepted,
                    ),
                  ),
                ),
              ],
            );
          }
          return Column(
            children: [
              Expanded(
                child: SwipeRefresh.adaptive(
                  onRefresh: wm.reloadAction,
                  stateStream: wm.reloadState.stream,
                  children: [
                    StreamedStateBuilder<List<UserAddress>>(
                      streamedState: wm.defaultAddressState,
                      builder: (_, addresses) => _AddressesList(
                        addresses: addresses,
                        onAddressTap: wm.addressTapAction,
                        title: addressesDefault,
                      ),
                    ),
                    StreamedStateBuilder<List<UserAddress>>(
                      streamedState: wm.additionalAddressesState,
                      builder: (_, addresses) => _AddressesList(
                        addresses: addresses,
                        onAddressTap: wm.addressTapAction,
                        title: addressesAdditional,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AcceptButton(
                  padding: EdgeInsets.zero,
                  text: addressAddNewAddressButton,
                  callback: wm.addNewAddressAction,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LoadingPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SkeletonWidget(width: 104, height: 28, radius: 16),
          SizedBox(height: 32),
          SkeletonWidget(height: 1),
          AddressTilePlaceholder(),
          SkeletonWidget(height: 1),
          SizedBox(height: 40),
          SkeletonWidget(width: 104, height: 28, radius: 16),
          SizedBox(height: 16),
          SkeletonWidget(height: 1),
          AddressTilePlaceholder(),
          SkeletonWidget(height: 1),
        ],
      ),
    );
  }
}

class _AddressesList extends StatelessWidget {
  const _AddressesList({
    Key key,
    this.addresses,
    this.onAddressTap,
    this.title,
  }) : super(key: key);
  final String title;
  final List<UserAddress> addresses;
  final Function(UserAddress) onAddressTap;

  @override
  Widget build(BuildContext context) {
    if (addresses == null || addresses.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(title: title),
        ...addresses.map(
          (address) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddressTile(
                address: address,
                onPress: onAddressTap,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(color: dividerLightColor, thickness: 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key key,
    this.title,
    this.needDivider = true,
  }) : super(key: key);

  final String title;
  final bool needDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 32, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textMedium24),
          const SizedBox(height: 16),
          if (needDivider ?? true)
            const Divider(color: dividerLightColor, thickness: 1),
        ],
      ),
    );
  }
}
