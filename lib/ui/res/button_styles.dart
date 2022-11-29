import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

final primaryButtonStyle = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
    primary: elevatedButtonPrimary,
    onPrimary: textColorAccent,
    textStyle: textMedium16Accent,
    elevation: 0,
  ),
);

final accentButtonStyle = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
    primary: buttonAccentColor,
    onPrimary: elevatedButtonPrimary,
    textStyle: textMedium16White,
    elevation: 0,
  ),
);

final textButtonStylePrimary = TextButtonThemeData(
  style: TextButton.styleFrom(
    textStyle: textRegular16,
  ),
);
