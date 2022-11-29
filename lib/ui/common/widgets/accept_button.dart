import 'package:flutter/material.dart' hide Action;
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/widget/common/loading_widget.dart';

/// Кнопка подтверждения действия
class AcceptButton extends StatelessWidget {
  const AcceptButton({
    Key key,
    this.callback,
    this.text,
    bool isLoad,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  })  : isLoad = isLoad ?? false,
        assert(text != null || (isLoad ?? false)),
        super(key: key);

  /// Текст кнопки
  final String text;

  /// Вид загрузки
  final bool isLoad;

  /// Клик по кнопке
  final VoidCallback callback;

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      color: white,
      width: double.infinity,
      padding: padding,
      child: Center(
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: isLoad ? null : callback,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) {
                  if (states.contains(MaterialState.disabled)) {
                    return isLoad ? cartButtonBackgroundColor : disableButton;
                  }
                  return cartButtonBackgroundColor;
                },
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            child: isLoad
                ? const LoadingWidget()
                : Text(
                    text,
                    style: textMedium16White,
                  ),
          ),
        ),
      ),
    );
  }
}
