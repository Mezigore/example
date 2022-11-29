import 'dart:math';

import 'package:flutter/material.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/common/widgets/input/address_input/address_input_wm.dart';
import 'package:uzhindoma/ui/common/widgets/input/address_input/di/address_input_component.dart';
import 'package:uzhindoma/ui/common/widgets/input/input_suggest.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/util/const.dart';

/// Ввод адреса с подсказками
class AddressInput extends MwwmWidget<AddressInputComponent> {
  AddressInput({
    Key key,
    TextEditingController controller,
    FocusNode focusNode,
    VoidCallback onEditingComplete,
  }) : super(
          key: key,
          widgetStateBuilder: () => _AddressInputState(onEditingComplete),
          dependenciesBuilder: (context) => AddressInputComponent(context),
          widgetModelBuilder: (context) => createAddressInputWidgetModel(
            context,
            controller,
            focusNode,
          ),
        );
}

class _AddressInputState extends WidgetState<AddressInputWidgetModel> {
  _AddressInputState(this.onEditingComplete);

  final VoidCallback onEditingComplete;

  OverlayState _overlayState;
  OverlayEntry _overlayEntry;
  RenderMetricsBox _metricsBox;

  @override
  Widget build(BuildContext context) {
    _overlayState = Overlay.of(context);
    return RenderMetricsObject<void>(
      onMount: (_, metrics) => _metricsBox = metrics,
      onUpdate: (_, metrics) => _metricsBox = metrics,
      child: StreamedStateBuilder<bool>(
        streamedState: wm.focusState,
        builder: (_, hasFocus) {
          if (hasFocus ?? false) {
            WidgetsBinding.instance.addPostFrameCallback(
              (timeStamp) => _showSuggests(),
            );
          } else {
            _closeOverlay();
          }
          return StreamedStateBuilder<String>(
            streamedState: wm.lastSelectionState,
            builder: (_, lastSelectedSuggest) => TextFormField(
              textInputAction: TextInputAction.done,
              controller: wm.textEditingController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              focusNode: wm.focusNode,
              style: textRegular16,
              keyboardType: TextInputType.streetAddress,
              onEditingComplete: () => onEditingComplete?.call(),
              minLines: 1,
              maxLines: 2,
              maxLength: 300,
              validator: (currentText) => _validate(
                currentText,
                lastSelectedSuggest,
              ),
              decoration: const InputDecoration(
                hintText: addressFormAddressLabel,
                errorStyle: TextStyle(height: 0, fontSize: 0),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _closeOverlay();
    super.dispose();
  }

  void _closeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showSuggests() {
    _closeOverlay();
    if (_metricsBox != null) {
      _overlayEntry = OverlayEntry(
        builder: (context) {
          /// Просчет на случай, если поле ввода близко к клавиатуре
          final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
          final screenHeight = MediaQuery.of(context).size.height;
          final offsetToBottom = screenHeight - bottomPadding;
          return StreamedStateBuilder<String>(
            streamedState: wm.currentInputState,
            builder: (_, searchedText) {
              return StreamedStateBuilder<List<String>>(
                streamedState: wm.suggestsState,
                builder: (context, suggests) {
                  if (suggests == null || suggests.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Stack(
                    children: [
                      Positioned(
                        top: _metricsBox.data.bottomLeft.y,
                        left: _metricsBox.data.bottomLeft.x,
                        child: Suggests(
                          onSelect: wm.selectAction,
                          width: _metricsBox.data.width,
                          suggests: suggests,
                          searchedText: searchedText,
                          maxHeight: min(
                            offsetToBottom - _metricsBox.data.bottomLeft.y,
                            212,
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            },
          );
        },
      );
      _overlayState.insert(_overlayEntry);
    }
  }

  String _validate(String currentText, String lastSuggest) {
    if (currentText != null &&
            currentText.isNotEmpty &&
            lastSuggest != null &&
            currentText == lastSuggest ||
        lastSuggest == null && wm.currentInputState.value == null) return null;
    return emptyString;
  }
}
