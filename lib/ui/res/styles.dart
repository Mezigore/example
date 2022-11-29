import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/text_field_border.dart';
import 'package:uzhindoma/ui/res/button_styles.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Основные стили
final themeData = ThemeData(
  primaryColor: colorPrimary,
  accentColor: colorAccent,
  accentColorBrightness: Brightness.light,
  backgroundColor: backgroundColor,
  appBarTheme: const AppBarTheme(
    color: appBarColor,
    brightness: Brightness.light,
    elevation: 4.0,
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelStyle: textMedium12Hint,
    labelStyle: textMedium12Accent,
  ),
  dividerTheme: const DividerThemeData(
    color: dividerLightColor,
    thickness: 1,
    indent: 0,
    endIndent: 0,
    space: 1,
  ),
  brightness: Brightness.light,
  buttonColor: btnColor,
  errorColor: colorError,
  scaffoldBackgroundColor: backgroundColor,
  hintColor: hintColor,
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    elevation: 8,
    shadowColor: Colors.black.withOpacity(0.08),
  ),
  textTheme: _textTheme,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    labelStyle: textRegular16Secondary,
    errorStyle: textRegular12Error,
    errorMaxLines: 2,
    fillColor: textFormFieldFillColor,
    counterStyle: textRegular.copyWith(height: 0, fontSize: 0),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    border: const UnderlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    errorBorder: const NoJumpOutLineBorder(
      borderSide: BorderSide(
        color: codeBorderColor,
        width: 2,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
    hintStyle: textRegular16Secondary,
    prefixStyle: textRegular16,
  ),
  // cursorColor: colorAccent,
  // textSelectionHandleColor: colorAccent,
  bottomSheetTheme: const BottomSheetThemeData(
    modalBackgroundColor: transparent,
    backgroundColor: transparent,
  ),
  elevatedButtonTheme: primaryButtonStyle,
  textButtonTheme: textButtonStylePrimary,
);

final _textTheme = TextTheme(
  overline: materialOverlineStyle,
  headline1: materialHeadline1Style,
  headline2: materialHeadline2Style,
  headline3: materialHeadline3Style,
  headline4: materialHeadline4Style,
  headline5: materialHeadline5Style,
  headline6: materialHeadline6Style,
  caption: materialCaptionStyle,
  button: materialButtonStyle,
  bodyText2: materialBody1Style,
  bodyText1: materialBody2Style,
  subtitle1: materialSubtitle1Style,
  subtitle2: materialSubtitle2Style,
);
