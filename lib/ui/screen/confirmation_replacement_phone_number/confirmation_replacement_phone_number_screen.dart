import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/phone_number.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/confirmation_replacement_phone_number/confirmation_replacement_phone_number_wm.dart';
import 'package:uzhindoma/ui/screen/confirmation_replacement_phone_number/di/confirmation_replacement_phone_number_component.dart';
import 'package:uzhindoma/util/const.dart';

/// Screen [ConfirmationReplacementPhoneNumberScreen]
/// экран подтверждения замены номера телефона
class ConfirmationReplacementPhoneNumberScreen
    extends MwwmWidget<ConfirmationReplacementPhoneNumberComponent> {
  ConfirmationReplacementPhoneNumberScreen({
    Key key,
    @required PhoneNumber phoneNumber,
  }) : super(
          key: key,
          widgetModelBuilder: (context) =>
              createConfirmationReplacementPhoneNumberWm(context, phoneNumber),
          dependenciesBuilder: (context) =>
              ConfirmationReplacementPhoneNumberComponent(context),
          widgetStateBuilder: () =>
              _ConfirmationReplacementPhoneNumberScreenState(),
        );
}

class _ConfirmationReplacementPhoneNumberScreenState
    extends WidgetState<ConfirmationReplacementPhoneNumberWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<ConfirmationReplacementPhoneNumberComponent>(context)
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: StreamedStateBuilder<EntityState<void>>(
            streamedState: wm.screenBehaviuorState,
            builder: (context, entityState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderWidget(
                    phoneNumber: wm.phoneNumber,
                  ),
                  _CodeWidget(
                    controller: wm.textFieldController.controller,
                    isError: entityState.hasError,
                    codeState: wm.codeState,
                  ),
                  _RequestWidget(
                    changeNumberAction: wm.changeNumberAction,
                    requestAgainAction: wm.requestAgainAction,
                    isRequestLockedState: wm.isRequestLockedState,
                    timerLockedState: wm.timerLockedState,
                    isLoad: entityState.isLoading,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({
    Key key,
    this.phoneNumber,
  }) : super(key: key);

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          confirmationScreenOtherSentTextMessageText,
          style: textRegular14Secondary,
        ),
        const SizedBox(height: 4),
        Text(
          phoneNumber,
          style: textRegular16,
        ),
        const SizedBox(height: 19),
      ],
    );
  }
}

class _CodeWidget extends StatelessWidget {
  const _CodeWidget({
    Key key,
    @required this.controller,
    @required bool isError,
    @required this.codeState,
  })  : isError = isError ?? false,
        super(key: key);

  final TextEditingController controller;
  final bool isError;
  final StreamedState<String> codeState;

  // высота textField  и контейнеров с кодом должна быть одинаковой
  static const double _height = 56;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 101,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamedStateBuilder<String>(
                streamedState: codeState,
                builder: (context, code) {
                  return Row(
                    children: [
                      for (int index = 0; index < 4; ++index)
                        _ElementCodeWidget(
                          height: _height,
                          isError: isError,
                          number: index < (code?.length ?? 0)
                              ? code[index]
                              : emptyString,
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              Opacity(
                opacity: isError ? 1 : 0,
                child: Text(
                  confirmationScreenInvalidCodeText,
                  style: textRegular14Error,
                ),
              ),
            ],
          ),

          /// скрытый виджет для прослушивания ввода
          Opacity(
            opacity: 0,
            child: SizedBox(
              height: _height,
              width: double.infinity,
              child: TextField(
                controller: controller,
                autofocus: true,
                keyboardType: TextInputType.number,
                maxLength: 4,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ElementCodeWidget extends StatelessWidget {
  const _ElementCodeWidget({
    Key key,
    @required this.height,
    @required this.number,
    @required this.isError,
  }) : super(key: key);

  // высота textField  и контейнеров с кодом должна быть одинаковой
  final double height;
  final String number;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 56,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: isError ? codeBorderColor : Colors.transparent,
            width: 2,
          ),
          color: codeContainerColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Text(
          number,
          style: textMedium24,
        ),
      ),
    );
  }
}

class _RequestWidget extends StatelessWidget {
  const _RequestWidget({
    Key key,
    @required this.requestAgainAction,
    @required this.changeNumberAction,
    @required this.timerLockedState,
    @required this.isRequestLockedState,
    @required this.isLoad,
  }) : super(key: key);

  final VoidCallback requestAgainAction;
  final VoidCallback changeNumberAction;
  final StreamedState<String> timerLockedState;
  final StreamedState<bool> isRequestLockedState;
  final bool isLoad;

  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<bool>(
      streamedState: isRequestLockedState,
      builder: (context, isRequestLocked) {
        final bool isLocked = (isRequestLocked ?? false) || isLoad;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: isLocked ? null : requestAgainAction,
              child: StreamedStateBuilder<String>(
                streamedState: timerLockedState,
                builder: (context, timer) {
                  return Text(
                    timer == null
                        ? confirmationScreenSendNewCodeText
                        : confirmationScreenSendNewCodeThroughText(timer),
                    style:
                        isLocked ? textRegular16Secondary : textRegular16Accent,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: isLoad ? null : changeNumberAction,
              child: Text(
                confirmationScreenOtherPhoneNumberText,
                style: isLoad ? textRegular16Secondary : textRegular16Accent,
              ),
            ),
          ],
        );
      },
    );
  }
}
