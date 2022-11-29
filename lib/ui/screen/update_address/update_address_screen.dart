import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/common/widgets/svg_icon_button.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/screen/update_address/di/update_address_screen_component.dart';
import 'package:uzhindoma/ui/screen/update_address/update_address_screen_wm.dart';
import 'package:uzhindoma/ui/widget/address_form/address_form.dart';

/// Экран изменения адреса
class UpdateAddressScreen extends MwwmWidget<UpdateAddressScreenComponent> {
  UpdateAddressScreen({
    Key key,
    @required int addressId,
    @required NewAddress initAddress,
  })  : assert(addressId != null),
        assert(initAddress != null),
        super(
          widgetModelBuilder: (context) => createUpdateAddressScreenWidgetModel(
            context,
            addressId,
          ),
          dependenciesBuilder: (context) =>
              UpdateAddressScreenComponent(context),
          widgetStateBuilder: () => _UpdateAddressScreenState(initAddress),
          key: key,
        );
}

class _UpdateAddressScreenState
    extends WidgetState<UpdateAddressScreenWidgetModel> {
  _UpdateAddressScreenState(this.initAddress);

  final NewAddress initAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<UpdateAddressScreenComponent>(context)
          .component
          .scaffoldKey,
      appBar: DefaultAppBar(
        leadingIcon: Icons.close,
        title: addressUpdateTitle,
        actions: [
          SvgIconButton(
            icDelete,
            onTap: wm.deleteAddressAction,
          )
        ],
      ),
      body: StreamedStateBuilder<bool>(
        streamedState: wm.isLoadingState,
        builder: (_, isLoading) => AbsorbPointer(
          absorbing: isLoading,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
            child: AddressForm(
              initAddress: initAddress,
              onAddressAccepted: wm.acceptAddressAction,
              checkBoxState: initAddress.isDefault
                  ? AddressPrimaryCheckBoxState.alwaysTrue
                  : AddressPrimaryCheckBoxState.selectable,
            ),
          ),
        ),
      ),
    );
  }
}
