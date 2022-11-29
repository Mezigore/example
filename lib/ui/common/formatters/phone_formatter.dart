import 'package:flutter/services.dart';

/// Форматтер для телефонного номера(копипаст с оф примера, пока что необходимо
/// ставить префикс phonePrefix)
class RuNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var value = newValue;
    if (newValue.text.length >= 11 &&
        (newValue.text.indexOf('8') == 0 || newValue.text.indexOf('7') == 0)) {
      value = newValue.copyWith(text: newValue.text.substring(1));
    }
    final int newTextLength = value.text.length;
    int selectionIndex = value.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();

    if (newTextLength >= 1) {
      newText.write('(');
      if (value.selection.end >= 1) selectionIndex++;
    }

    if (newTextLength >= 4) {
      newText.write('${value.text.substring(0, usedSubstringIndex = 3)}) ');
      if (value.selection.end >= 3) selectionIndex += 2;
    }

    if (newTextLength >= 7) {
      newText.write('${value.text.substring(3, usedSubstringIndex = 6)}-');
      if (value.selection.end >= 6) selectionIndex++;
    }

    if (newTextLength >= 9) {
      newText.write('${value.text.substring(6, usedSubstringIndex = 8)}-');
      if (value.selection.end >= 8) selectionIndex++;
    }

    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(value.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
