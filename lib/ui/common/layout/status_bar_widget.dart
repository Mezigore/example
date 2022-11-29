import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// виджет для настройки статус-бара
/// [child] - дочерний виджет для вёрстки всего остального экрана
///
/// [statusBarColor] - цвет статус-бара (по-умолчанию прозрачный)
///
/// [iconTone] - тон иконок в статус-баре (светлые/тёмные)
///
/// Работает корректно и для Android L+ и для iOS.
/// - Android M+ поддерживает полную прозрачность статус-бара и два тона иконок;
/// - Android L всегда будет отображать полупрозрачный статус-бар и белые иконки
/// - iOS поддерживает полную прозрачность статус-бара и два тона иконок.
class StatusBarWidget extends StatelessWidget {
  const StatusBarWidget({
    @required this.child,
    Key key,
    Color statusBarColor,
    StatusBarIconTone statusBarIconTone,
  })  : assert(child != null),
        statusBarColor = statusBarColor ?? Colors.transparent,
        iconTone = statusBarIconTone ?? StatusBarIconTone.dark,
        super(key: key);

  final Widget child;
  final Color statusBarColor;
  final StatusBarIconTone iconTone;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          brightness: StatusBarConfig._getAppBarThemeBrightness(iconTone),
        ),
      ),
      child: AnnotatedRegion(
        value: StatusBarConfig.getSystemUiOverlayStyle(
          statusBarColor,
          iconTone,
        ),
        child: child,
      ),
    );
  }
}

/// виджет для статус-бара со светлыми иконками
///
/// [statusBarColor] - цвет статус-бара (по-умолчанию прозрачный)
class LightIconStatusBarWidget extends StatusBarWidget {
  const LightIconStatusBarWidget({
    @required Widget child,
    Key key,
    Color statusBarColor,
  }) : super(
          key: key,
          child: child,
          statusBarColor: statusBarColor,
          statusBarIconTone: StatusBarIconTone.light,
        );
}

/// виджет для статус-бара с тёмными иконками
///
/// [statusBarColor] - цвет статус-бара (по-умолчанию прозрачный)
class DarkIconStatusBarWidget extends StatusBarWidget {
  const DarkIconStatusBarWidget({
    @required Widget child,
    Key key,
    Color statusBarColor,
  }) : super(
          key: key,
          child: child,
          statusBarColor: statusBarColor,
          statusBarIconTone: StatusBarIconTone.dark,
        );
}

/// Конфигуратор для статус-бара
class StatusBarConfig {
  static SystemUiOverlayStyle getSystemUiOverlayStyle(
    Color statusBarColor,
    StatusBarIconTone iconTone,
  ) {
    return SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: _getStatusBarIconBrightness(iconTone),
      statusBarBrightness: _getStatusBarBrightness(iconTone),
    );
  }

  /// настройка цвета иконок для Android (M+)
  static Brightness _getStatusBarIconBrightness(StatusBarIconTone iconTone) {
    if (iconTone == StatusBarIconTone.dark) {
      return Brightness.dark;
    } else if (iconTone == StatusBarIconTone.light) {
      return Brightness.light;
    }
    return null;
  }

  /// настройка цвета иконок для iOS
  static Brightness _getStatusBarBrightness(StatusBarIconTone iconTone) {
    // не ошибка, тона действительно нужно инвертировать
    if (iconTone == StatusBarIconTone.dark) {
      return Brightness.light;
    } else if (iconTone == StatusBarIconTone.light) {
      return Brightness.dark;
    }
    return null;
  }

  /// настройка яркости для AppBarTheme
  ///
  /// (код идентичен методу _getStatusBarBrightness(), но семантически несёт
  /// иной смысл)
  static Brightness _getAppBarThemeBrightness(StatusBarIconTone iconTone) {
    // не ошибка, тона действительно нужно инвертировать
    if (iconTone == StatusBarIconTone.dark) {
      return Brightness.light;
    } else if (iconTone == StatusBarIconTone.light) {
      return Brightness.dark;
    }
    return null;
  }
}

/// Вариант окраски иконок в статус-баре
///
/// DARK - тёмные иконки
/// LIGHT - белые иконки
enum StatusBarIconTone {
  dark,
  light,
}
