import 'package:flutter/material.dart' hide Action;
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/common/widgets/input/phone_input.dart';
import 'package:uzhindoma/ui/common/widgets/radio.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_address/di/select_address_screen_component.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_address/select_address_screen_wm.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_address/widgets/address_fields.dart';
import 'package:uzhindoma/util/const.dart';

/// Экран выбора адреса для доставки
class SelectAddressScreen extends MwwmWidget<SelectAddressScreenComponent> {
  SelectAddressScreen({
    Key key,
    bool isForSelf = true,
  }) : super(
          key: key,
          widgetStateBuilder: () => _SelectAddressScreenState(),
          dependenciesBuilder: (context) =>
              SelectAddressScreenComponent(context),
          widgetModelBuilder: (context) => createSelectAddressScreenWidgetModel(
            context,
            isForSelf,
          ),
        );
}

class _SelectAddressScreenState
    extends WidgetState<SelectAddressScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        wm.cancelOrderAction();
        return Future.value(false);
      },
      child: Scaffold(
        key: Injector.of<SelectAddressScreenComponent>(context)
            .component
            .scaffoldKey,
        appBar: DefaultAppBar(
          title: createOrderTitle,
          leadingIcon: Icons.close,
          onLeadingTap: wm.cancelOrderAction,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    createOrderAddressTitle,
                    style: textMedium24,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: StreamedStateBuilder<UserAddress>(
                    streamedState: wm.addressState,
                    builder: (_, address) {
                      return AddressFields(
                        address: address,
                        onAddressPressed: wm.addressTapAction,
                        commentController: wm.commentTextController,
                      );
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: TextButton(
                    onPressed: wm.addAddressAction,
                    child: const Text(addressAddNewAddressButton),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 30)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: StreamedStateBuilder<bool>(
                    streamedState: wm.anotherClientState,
                    builder: (_, isAnotherSelected) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => wm.anotherClientChangeAction(
                          !isAnotherSelected,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleRadio(isSelected: isAnotherSelected),
                              const SizedBox(width: 10),
                              Text(
                                createOrderAnotherClient,
                                style: textRegular16,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: StreamedStateBuilder<bool>(
                    streamedState: wm.anotherClientState,
                    builder: (_, isAnotherSelected) {
                      return isAnotherSelected ?? false
                          ? _AnotherClientInput(
                              formKey: wm.formKey,
                              nameController: wm.nameTextController,
                              phoneController: wm.phoneController.controller,
                              validState: wm.phoneValidState,
                            )
                          : const SizedBox();
                    },
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AcceptButton(
                    callback: wm.nextAction,
                    text: createOrderBtnNextTitle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnotherClientInput extends StatelessWidget {
  const _AnotherClientInput({
    Key key,
    this.nameController,
    this.phoneController,
    this.validState,
    this.formKey,
  }) : super(key: key);

  final Key formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final StreamedState<String> validState;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: userDetailsWidgetNameText,
              errorStyle: TextStyle(height: 0),
            ),
            validator: (text) => (text?.isEmpty ?? true) ? emptyString : null,
          ),
          const SizedBox(height: 16),
          PhoneInput(
            controller: phoneController,
            validState: validState,
            isEnable: true,
            autofocus: false,
          ),
        ],
      ),
    );
  }
}
