import 'package:flutter/widgets.dart';

/// Контроллер решает проблему, когда после вставки курсор убегает в начало
class FixedEditController extends TextEditingController {
  @override
  set text(String newText) {
    if (super.text != newText) {
      value = value.copyWith(
        text: newText,
        selection: TextSelection.fromPosition(
          TextPosition(offset: (newText ?? '').length),
        ),
        composing: TextRange.empty,
      );
    }
  }
}
