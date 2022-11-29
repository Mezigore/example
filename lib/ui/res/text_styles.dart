import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/colors.dart';

/// Стили текстов
final TextStyle _text = const TextStyle(
      fontStyle: FontStyle.normal,
      color: textColorPrimary,
      fontFamily: 'Rubik',
    ),

//Light
    textLight = _text.copyWith(fontWeight: FontWeight.w300),

//Regular
    textRegular = _text.copyWith(fontWeight: FontWeight.normal),
    textRegular10 = textRegular.copyWith(fontSize: 10.0),
    textRegular12 = textRegular.copyWith(fontSize: 12.0),
    textRegular12WhiteOpacityCross = textRegular12.copyWith(
      color: textColorWhiteOpacity,
      decoration: TextDecoration.lineThrough,
    ),
    textRegular12Secondary = textRegular12.copyWith(
      color: textColorSecondary,
      height: 1.33,
    ),
    textRegular12SecondaryUnderline = textRegular12.copyWith(
      color: textColorSecondary,
      decoration: TextDecoration.underline,
      height: 1.33,
    ),
    textRegular12Hint = textRegular12.copyWith(
      color: textColorHint,
      height: 1.29,
    ),
    textRegular12Blue = textRegular12.copyWith(color: textColorAccent),
    textRegular12Gray = textRegular12.copyWith(color: textColorGrey),
    textRegular12Error = textRegular12.copyWith(color: textColorError),
//14
    textRegular14 = textRegular.copyWith(fontSize: 14.0, height: 1.29),
    textRegular14Secondary = textRegular14.copyWith(color: textColorSecondary),
    textRegular14White = textRegular14.copyWith(color: textColorWhite),
    textRegular14Hint = textRegular14.copyWith(color: textColorHint),
    textRegular14Error = textRegular14.copyWith(color: textColorError),
//16
    textRegular16 = textRegular.copyWith(fontSize: 16.0, height: 1.25),
    textRegular16Secondary = textRegular16.copyWith(color: textColorSecondary),
    textRegular16Grey = textRegular16.copyWith(color: textColorGrey),
    textRegular16White = textRegular16.copyWith(color: textColorWhite),
    textRegular16Hint = textRegular16.copyWith(color: textColorHint),
    textRegular16Accent = textRegular16.copyWith(color: textColorAccent),
    textRegular16WhiteOpacity =
        textRegular16.copyWith(color: textColorWhiteOpacity),
    textRegular16WhiteOpacityCross = textRegular16WhiteOpacity.copyWith(
      decoration: TextDecoration.lineThrough,
    ),
//20
    textRegular20 = textRegular.copyWith(fontSize: 20.0),
    textRegular20Accent = textRegular20.copyWith(color: textColorAccent),

//Medium
    textMedium = _text.copyWith(fontWeight: FontWeight.w500),
//9
    textMedium9 = textMedium.copyWith(
      fontSize: 9.0,
      height: 1.78,
    ),
    textMedium9Error = textMedium9.copyWith(color: textColorError),
//12
    textMedium12 = textMedium.copyWith(
      fontSize: 12.0,
      height: 1.33,
    ),
    textMedium12Accent = textMedium12.copyWith(color: textColorAccent),
    textMedium12Hint = textMedium12.copyWith(color: textColorHint),

//14
    textMedium14 = textMedium.copyWith(
      fontSize: 14.0,
      height: 1.29,
    ),
    textMedium14Hint = textMedium14.copyWith(color: textColorHint),
    textMedium14Secondary = textMedium14.copyWith(color: textColorSecondary),
//16
    textMedium16 = textMedium.copyWith(fontSize: 16.0, height: 1.25),
    textMedium16Hint = textMedium16.copyWith(color: textColorHint),
    textMedium16Accent = textMedium16.copyWith(color: textColorAccent),
    textMedium16White = textMedium16.copyWith(color: white),
// 18
    textMedium18 = textMedium.copyWith(fontSize: 18.0, height: 1.11),
    textMedium18White = textMedium18.copyWith(color: white),
// 20

    textMedium20 = textMedium.copyWith(
      fontSize: 20.0,
    ),
    textMedium24 = textMedium.copyWith(fontSize: 24.0, height: 1.08),
    textMedium24White = textMedium24.copyWith(color: white),
    textMedium32 = textMedium.copyWith(fontSize: 32.0),

//Bold
    textBold = _text.copyWith(fontWeight: FontWeight.bold),

// шрифты используемые семантически Material
    materialCaptionStyle =
        textRegular12.copyWith(height: 1.33, color: textColorSecondary),
    materialOverlineStyle = textMedium9.copyWith(height: 1.78),
    materialButtonStyle = textMedium14.copyWith(),
    materialBody2Style = textRegular14Hint.copyWith(height: 1.29),
    materialBody1Style = textRegular16Secondary.copyWith(),
    materialSubtitle2Style = textMedium14.copyWith(),
    materialSubtitle1Style = textRegular16.copyWith(),
    materialHeadline1Style = textMedium18.copyWith(height: 1.11),
    materialHeadline2Style = textLight.copyWith(fontSize: 60),
    materialHeadline3Style = textRegular.copyWith(fontSize: 48),
    materialHeadline4Style = textMedium16.copyWith(),
    materialHeadline5Style = textMedium24.copyWith(),
    materialHeadline6Style = textMedium20.copyWith();
