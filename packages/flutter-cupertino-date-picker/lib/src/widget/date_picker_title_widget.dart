import 'package:flutter/material.dart';

import '../date_picker_constants.dart';
import '../date_picker_theme.dart';
import '../i18n/date_picker_i18n.dart';

/// DatePicker's title widget.
///
/// @author dylan wu
/// @since 2019-05-16
class DatePickerTitleWidget extends StatelessWidget {
  const DatePickerTitleWidget({
    Key key,
    this.pickerTheme,
    this.locale,
    @required this.onCancel,
    @required this.onConfirm,
  }) : super(key: key);

  final DateTimePickerTheme pickerTheme;
  final DateTimePickerLocale locale;
  final DateVoidCallback onCancel, onConfirm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
      child: _AcceptButton(
        callback: onConfirm,
        text: 'Готово',
      ),
    );
  }

  /// render cancel button widget
  Widget _renderCancelWidget(BuildContext context) {
    if (isCustomTitleWidget()) {
      // has custom title button widget
      if (pickerTheme.cancel == null) {
        return const Offstage();
      }
    }

    Widget cancelWidget = pickerTheme.cancel;
    if (cancelWidget == null) {
      final TextStyle textStyle = pickerTheme.cancelTextStyle ??
          TextStyle(
            color: Theme.of(context).unselectedWidgetColor,
            fontSize: 16.0,
          );
      cancelWidget = Text(
        DatePickerI18n.getLocaleCancel(locale),
        style: textStyle,
      );
    }

    return SizedBox(
      height: pickerTheme.titleHeight,
      child: TextButton(
        onPressed: onCancel,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder()),
        ),
        child: cancelWidget,
      ),
    );
  }

  /// render confirm button widget
  Widget _renderConfirmWidget(BuildContext context) {
    if (isCustomTitleWidget()) {
      // has custom title button widget
      if (pickerTheme.confirm == null) {
        return const Offstage();
      }
    }

    Widget confirmWidget = pickerTheme.confirm;
    if (confirmWidget == null) {
      final TextStyle textStyle = pickerTheme.confirmTextStyle ??
          TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16.0,
          );
      confirmWidget = Text(
        DatePickerI18n.getLocaleDone(locale),
        style: textStyle,
      );
    }

    return SizedBox(
      height: pickerTheme.titleHeight,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder()),
        ),
        onPressed: onConfirm,
        child: confirmWidget,
      ),
    );
  }

  bool isCustomTitleWidget() {
    return pickerTheme.cancel != null ||
        pickerTheme.confirm != null ||
        pickerTheme.title != null;
  }
}

/// Кнопка подтверждения действия
class _AcceptButton extends StatelessWidget {
  const _AcceptButton({
    Key key,
    @required this.text,
    @required this.callback,
  })  : assert(text != null),
        super(key: key);

  /// Текст кнопки
  final String text;

  /// Клик по кнопке
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          primary: const Color(0xFF2D7DE1),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontStyle: FontStyle.normal,
            color: Colors.white,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.25,
          ),
        ),
      ),
    );
  }
}
