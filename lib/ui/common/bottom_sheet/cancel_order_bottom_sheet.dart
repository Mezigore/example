import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/res/button_styles.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

import '../../../util/const.dart';
import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/strings/strings.dart';

/// BottomSheet с отменой заказа и выбором причины
class CancelOrderBottomSheet extends StatefulWidget {
  const CancelOrderBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  _CancelOrderBottomSheetState createState() => _CancelOrderBottomSheetState();
}

class _CancelOrderBottomSheetState extends State<CancelOrderBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  String _selectedReason = '';

  final _reasons = [
    orderCancelReasonLeave,
    orderCancelReasonMenu,
    orderCancelReasonDate,
    orderCancelReasonPayment,
    orderCancelReasonAnotherService,
    orderCancelReasonAnotherOrder,
    orderCancelReasonOther,
  ];
  final _selectReasons = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  String validateField(String value) {
    return value.isEmpty ? '' : null;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 32),
              Text(
                orderCancelConfirmedTitle,
                style: textMedium24,
              ),
              const SizedBox(height: 8),
              Text(
                orderCancelReasonSubtitle,
                style: textRegular14Secondary,
              ),
              const SizedBox(height: 24),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _reasons.length,
                itemBuilder: (_, index) {
                  return _reasonWidget(
                      title: _reasons[index],
                      selected: _selectReasons[index],
                      tap: () {
                        setState(() {
                          _selectReasons.fillRange(0, 7, false);
                          _selectReasons[index] = true;
                          if (index != 6) {
                            _selectedReason = _reasons[index];
                          }
                        });
                      });
                },
                separatorBuilder: (_, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
              ),
              const SizedBox(height: 16),
              if (_selectReasons[6]) ...[
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SizedBox(
                    height: 56,
                    child: _TextField(
                      labelText: orderCancelReasonComment,
                      textInputType: TextInputType.text,
                      validator: validateField,
                      controller: _controller,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: primaryButtonStyle.style,
                  onPressed: () => Navigator.of(context).pop(''),
                  child: const Text(orderCancelPaidCancel),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: accentButtonStyle.style,
                  onPressed: () {
                    if(_selectReasons[6]){
                      if(_controller.text.isNotEmpty){
                        return Navigator.of(context).pop(_controller.text);
                      }
                    }else{
                      if(_selectReasons.contains(true)){
                        return Navigator.of(context).pop(_selectedReason);
                      }else{
                        Fluttertoast.showToast(
                          msg: 'Укажите причину отмены',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,);
                      }
                    }
                  },
                  child: const Text(orderCancelConfirmedAccept),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _reasonWidget({String title, bool selected, VoidCallback tap}) {
  return InkWell(
    onTap: tap,
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        SvgPicture.asset(
          selected ? icCancelOrderSelectCheckbox : icCancelOrderCheckbox,
          height: 20,
          width: 20,
        ),
        const SizedBox(
          width: 18,
        ),
        Text(
          title,
          style: textRegular16,
        ),
      ],
    ),
  );
}

class _TextField extends StatefulWidget {
  const _TextField({
    @required this.labelText,
    @required this.textInputType,
    @required this.validator,
    this.textInputAction,
    this.controller,
    this.focusNode,
    this.isEnable,
    this.suffixIcon,
    Key key,
    this.style,
    this.onAddFocusNode,
    this.onRemoveFocusNode,
  })  : assert(labelText != null),
        assert(validator != null),
        super(key: key);

  final TextStyle style;
  final FocusNode focusNode;
  final bool isEnable;

  final TextInputAction textInputAction;

  /// Контроллер ввода
  final TextEditingController controller;

  final String labelText;

  /// Иконка
  final IconData suffixIcon;

  final TextInputType textInputType;

  final FormFieldValidator<String> validator;

  final ValueChanged<FocusNode> onAddFocusNode;
  final ValueChanged<FocusNode> onRemoveFocusNode;

  @override
  State<StatefulWidget> createState() {
    return _TextFieldState();
  }
}

class _TextFieldState extends State<_TextField> {
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _validator,
      focusNode: _focusNode,
      controller: widget.controller,
      enabled: widget.isEnable,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      style: widget.style ?? textRegular16,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: 100,
      autocorrect: false,
      decoration: InputDecoration(
        enabled: widget.isEnable ?? true,
        filled: true,
        counterText: emptyString,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        labelText: widget.labelText,
        labelStyle: textRegular16Secondary,
        errorStyle: textRegular12Error.copyWith(height: 0),
        errorMaxLines: 2,
        fillColor: textFormFieldFillColor,
        suffixIcon: widget.suffixIcon == null
            ? null
            : Icon(
                widget.suffixIcon,
                size: 16,
                color: iconColor40o,
              ),
      ),
    );
  }

  String _validator(String text) {
    final errorText = widget.validator(text);
    if (errorText != null) {
      widget.onAddFocusNode?.call(_focusNode);
    } else {
      widget.onRemoveFocusNode?.call(_focusNode);
    }
    return errorText;
  }
}
