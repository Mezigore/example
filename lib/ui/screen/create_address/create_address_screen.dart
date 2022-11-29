import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/screen/create_address/create_address_screen_wm.dart';
import 'package:uzhindoma/ui/screen/create_address/di/create_address_screen_component.dart';
import 'package:uzhindoma/ui/widget/address_form/address_form.dart';

/// Экран создания/редактирования адреса
class CreateAddressScreen extends MwwmWidget<CreateAddressScreenComponent> {
  CreateAddressScreen({Key key})
      : super(
          widgetModelBuilder: createCreateAddressScreenWidgetModel,
          dependenciesBuilder: (context) =>
              CreateAddressScreenComponent(context),
          widgetStateBuilder: () => _CreateAddressScreenState(),
          key: key,
        );
}

class _CreateAddressScreenState
    extends WidgetState<CreateAddressScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<CreateAddressScreenComponent>(context)
          .component
          .scaffoldKey,
      appBar: const DefaultAppBar(
        leadingIcon: Icons.close,
        title: addressCreateTitle,
      ),
      body: StreamedStateBuilder<bool>(
        streamedState: wm.isLoadingState,
        builder: (_, isLoading) => AbsorbPointer(
          absorbing: isLoading,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
            child: AddressForm(
              onAddressAccepted: wm.acceptAddressAction,
              checkBoxState: AddressPrimaryCheckBoxState.selectable,
            ),
          ),
        ),
      ),
    );
  }
}
