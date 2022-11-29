import 'package:uzhindoma/domain/time.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/util/const.dart';

/// Утилиты для форматирования времени
class TimeFormatter {
  /// форматирует [TimeDuration] в строку
  /// прим.: 6 дней 12 часов 30 минут
  static String formatToString(TimeDuration duration, {bool isShort}) {
    isShort ??= false;

    final result = StringBuffer();

    final days = duration.days;
    final hours = duration.hours;
    final minutes = duration.minutes;

    if (days != 0) {
      if (isShort) {
        result..write(days)..write(space)..write(daysShort)..write(space);
      } else {
        result..write(daysText(days))..write(space);
      }
    }

    if (hours != 0) {
      if (isShort) {
        result..write(hours)..write(space)..write(hourShort)..write(space);
      } else {
        result..write(hoursText(hours))..write(space);
      }
    }

    if (minutes != 0 || duration.inMinutes == 0) {
      if (isShort) {
        result..write(minutes)..write(space)..write(minutesShort)..write(space);
      } else {
        result..write(minutesText(minutes))..write(space);
      }
    }

    return result.toString().trim();
  }
}
