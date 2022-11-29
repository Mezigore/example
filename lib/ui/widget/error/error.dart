import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Виджет ошибки
class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    @required this.onReloadAction,
    Key key,
  }) : super(key: key);

  final VoidCallback onReloadAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              profileScreenErrorText,
              style: textRegular14Hint,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ClipOval(
              child: Material(
                color: elevatedButtonPrimary, // button color
                child: InkWell(
                  onTap: onReloadAction,
                  splashColor: pressedButton, // inkwell color
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: SvgPicture.asset(
                        icArrowReload,
                        height: 24,
                        width: 24,
                        color: iconColorAccent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
