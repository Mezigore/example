import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/create_address/create_order_address_screen_wm.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/create_address/di/create_order_address_screen_component.dart';
import 'package:uzhindoma/ui/widget/address_form/address_form.dart';

/// Экран выбора адреса для доставки
class CreateOrderAddressScreen
    extends MwwmWidget<CreateOrderAddressScreenComponent> {
  CreateOrderAddressScreen({
    Key key,
    bool canGoBack,
  }) : super(
          dependenciesBuilder: (context) =>
              CreateOrderAddressScreenComponent(context),
          widgetStateBuilder: () => _SelectAddressScreenState(),
          key: key,
          widgetModelBuilder: (context) => createSelectAddressScreenWidgetModel(
            context,
            canGoBack,
          ),
        );
}

class _SelectAddressScreenState
    extends WidgetState<CreateOrderScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        wm.cancelOrderAction();
        return Future.value(false);
      },
      child: Scaffold(
        key: Injector.of<CreateOrderAddressScreenComponent>(context)
            .component
            .scaffoldKey,
        appBar: DefaultAppBar(
          leadingIcon: Icons.close,
          title: createOrderTitle,
          onLeadingTap: wm.cancelOrderAction,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                createOrderAddressTitle,
                style: textMedium24,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: AddressForm(
                  onAddressAccepted: wm.addressValidatedAction,
                  acceptButtonText: createOrderBtnNextTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
