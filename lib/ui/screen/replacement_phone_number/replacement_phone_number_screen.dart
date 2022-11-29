import 'package:flutter/material.dart' hide Action;
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/common/widgets/input/phone_input.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/replacement_phone_number/di/replacement_phone_number_component.dart';
import 'package:uzhindoma/ui/screen/replacement_phone_number/replacement_phone_number_wm.dart';

/// Screen [ReplacementPhoneNumberScreen] смена номера телефона
class ReplacementPhoneNumberScreen
    extends MwwmWidget<ReplacementPhoneNumberComponent> {
  ReplacementPhoneNumberScreen({
    Key key,
  }) : super(
          key: key,
          widgetModelBuilder: createReplacementPhoneNumberWm,
          dependenciesBuilder: (context) =>
              ReplacementPhoneNumberComponent(context),
          widgetStateBuilder: () => _ReplacementPhoneNumberScreenState(),
        );
}

class _ReplacementPhoneNumberScreenState
    extends WidgetState<ReplacementPhoneNumberWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<ReplacementPhoneNumberComponent>(context)
          .component
          .scaffoldKey,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          replacementPhoneNumberScreenChangeTheNumberText,
          style: textMedium16,
        ),
        leading: Center(
          child: IconButton(
            splashRadius: 24,
            onPressed: wm.onBackAction,
            icon: const Icon(
              Icons.close,
              size: 20,
              color: Colors.black87,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamedStateBuilder<EntityState<void>>(
          streamedState: wm.screenBehaviuorState,
          builder: (context, entityState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 32),
                PhoneInput(
                  controller: wm.phoneController.controller,
                  validState: wm.validState,
                  focusNode: wm.phoneFocusNode,
                  isEnable: true,
                  isValid: entityState.hasError ? false : null,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    replacementPhoneNumberScreenChangeTheNumberInfoText,
                    style: textRegular12Secondary,
                  ),
                ),
                const Spacer(),
                StreamedStateBuilder<bool>(
                  streamedState: wm.acceptButtonState,
                  builder: (context, snapshot) {
                    return AcceptButton(
                      callback:
                          (snapshot ?? false) ? wm.onAcceptButtonAction : null,
                      text: replacementPhoneNumberScreenNextText,
                      padding: EdgeInsets.zero,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
