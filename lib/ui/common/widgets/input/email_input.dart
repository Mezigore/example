import 'dart:math';

import 'package:flutter/material.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/common/widgets/input/fixed_edit_controller.dart';
import 'package:uzhindoma/ui/common/widgets/input/input_suggest.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/util/reg_exps.dart';
import 'package:uzhindoma/util/validate_data.dart';

const _emailSuffix = [
  'mail.ru',
  'gmail.com',
  'yandex.ru',
];

/// Текстовое поле для ввода электронной почты
class EmailEditText extends StatefulWidget {
  EmailEditText({
    Key key,
    TextEditingController controller,
    FocusNode focusNode,
  })  : controller = controller ?? FixedEditController(),
        focusNode = focusNode ?? FocusNode(),
        super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  _EmailEditTextState createState() => _EmailEditTextState();
}

class _EmailEditTextState extends State<EmailEditText> {
  OverlayState _overlayState;
  OverlayEntry _overlayEntry;
  RenderMetricsBox _metricsBox;

  final _focusState = StreamedState<bool>(false);
  final _currentEmailState = StreamedState<String>();

  String get _currentText => widget.controller.text;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_listenFocus);
    widget.controller.addListener(_listenTextController);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_listenFocus);
    widget.controller.removeListener(_listenTextController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RenderMetricsObject<void>(
      onMount: (_, metrics) => _metricsBox = metrics,
      onUpdate: (_, metrics) => _metricsBox = metrics,
      child: StreamedStateBuilder<bool>(
        streamedState: _focusState,
        builder: (_, hasFocus) {
          if (hasFocus ?? false) {
            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) => _showSuggests(),
            );
          } else {
            _closeOverlay();
          }
          return TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: userDetailsWidgetEmailText,
            ),
            inputFormatters: [formatEmail],
          );
        },
      ),
    );
  }

  void _closeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showSuggests() {
    _overlayState = Overlay.of(context);
    _closeOverlay();
    if (_metricsBox != null) {
      _overlayEntry = OverlayEntry(
        builder: (context) {
          /// Просчет на случай, если поле ввода близко к клавиатуре
          final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
          final screenHeight = MediaQuery.of(context).size.height;
          final offsetToBottom = screenHeight - bottomPadding;
          return Stack(
            children: [
              Positioned(
                top: _metricsBox.data.bottomLeft.y,
                left: _metricsBox.data.bottomLeft.x,
                child: StreamedStateBuilder<String>(
                    streamedState: _currentEmailState,
                    builder: (context, snapshot) {
                      if (_currentText == null ||
                          _currentText.isEmpty ||
                          _currentText.contains('@')) return const SizedBox();
                      return Suggests(
                        onSelect: (suggest) => widget.controller.text = suggest,
                        width: _metricsBox.data.width,
                        suggests: _getSuggests(),
                        searchedText: widget.controller.text,
                        maxHeight: min(
                          offsetToBottom - _metricsBox.data.bottomLeft.y,
                          212,
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      );
      _overlayState.insert(_overlayEntry);
    }
  }

  List<String> _getSuggests() {
    final currentEmail = widget.controller.text;
    return _emailSuffix.map((suffix) => '$currentEmail@$suffix').toList();
  }

  void _listenFocus() {
    _focusState.accept(widget.focusNode.hasFocus);
  }

  void _listenTextController() {
    _currentEmailState.accept(widget.controller.text);
  }

  String _validateEmail(String value) {
    final bool isValid = emailReg.hasMatch(value);
    return isValid ? null : '';
  }
}
