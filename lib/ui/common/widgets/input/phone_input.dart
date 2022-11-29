import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/common/formatters/phone_formatter.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/util/const.dart';

/// Виджет ввода номера телефона
class PhoneInput extends StatefulWidget {
  PhoneInput({
    Key key,
    @required this.controller,
    @required this.validState,
    this.isValid,
    bool isEnable,
    bool autofocus,
    this.suffixIcon,
    this.focusNode,
  })  : isEnable = isEnable ?? true,
        autofocus = autofocus ?? true,
        assert(controller != null),
        assert(validState != null),
        super(key: key);

  final bool autofocus;

  final bool isEnable;

  /// форматтер для ввода номера
  final _phoneNumberFormatter = RuNumberTextInputFormatter();

  /// Контроллер ввода
  final TextEditingController controller;

  final FocusNode focusNode;

  /// Состояние валидации
  final StreamedState<String> validState;

  /// Принудительно указать валидность
  final bool isValid;

  final IconData suffixIcon;

  @override
  State<StatefulWidget> createState() {
    return _PhoneInputState();
  }
}

class _PhoneInputState extends State<PhoneInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<String>(
      streamedState: widget.validState,
      builder: (context, validationError) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.isValid ?? validationError == null
                  ? Colors.transparent
                  : textFormFieldErrorBorderColor,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Form(
            key: _formKey,
            child: TextFormField(
              autofocus: widget.autofocus,
              maxLength: 15,
              enabled: widget.isEnable,
              focusNode: widget.focusNode,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              style: widget.isEnable ? textRegular16 : textRegular16Secondary,
              controller: widget.controller,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                widget._phoneNumberFormatter,
              ],
              decoration: InputDecoration(
                enabled: widget.isEnable,
                filled: true,
                counterText: emptyString,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                prefixStyle:
                    widget.isEnable ? textRegular16 : textRegular16Secondary,
                prefixText: '$prefixPhoneNumberText$space',
                labelText: phoneInputWidgetLabelText,
                fillColor: textFormFieldFillColor,
                labelStyle: textRegular16Secondary,
                suffixIcon:
                    widget.suffixIcon == null ? null : Icon(widget.suffixIcon),
                errorStyle: textRegular12Error,
                errorMaxLines: 2,
                border: getInputBorder(),
              ),
            ),
          ),
        );
      },
    );
  }

  InputBorder getInputBorder() => const UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      );
}
