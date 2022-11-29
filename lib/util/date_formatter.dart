import 'package:intl/intl.dart';
import 'package:uzhindoma/ui/res/locale.dart';
import 'package:uzhindoma/util/const.dart';

const utcFormat = 'YYYY-MM-DDThh:mmTZD';
const hhMmFormat = 'HH:mm';
const edMMM = 'EE, d MMMM';

/// Утилиты для [DateTime]
class DateUtil {
  static final DateFormat dayMonthFormatter = DateFormat(
    'd MMMM',
    ruLocaleString,
  );

  static final DateFormat dayMonthYearFormatter = DateFormat.yMMMMd(
    ruLocaleString,
  );

  static final DateFormat dayWeekDayMonth = DateFormat(edMMM, ruLocaleString);

  /// Вид: 19 сентября
  static String formatToDate(DateTime date) {
    return dayMonthFormatter.format(date);
  }

  /// Вид: ПН, 22 сентября
  static String formatDayWeekDayMonth(DateTime date) {
    final lowCase = dayWeekDayMonth.format(date);
    return lowCase.substring(0, 2).toUpperCase() + lowCase.substring(2);
  }

  /// Вид: 22 сентября, ПН
  static String formatDayMonthDayWeek(DateTime date) {
    final lowCase = dayWeekDayMonth.format(date);
    return '${lowCase.substring(3)}, ${lowCase.substring(0, 2).toUpperCase()}';
  }

  static String formatToDateDayMonthYear(DateTime date) =>
      dayMonthYearFormatter.format(date);

  static String formatToDateRange(DateTime start, DateTime end) {
    if (start.year == end.year && start.month == end.month) {
      return '${start.day} - ${formatToDate(end)}';
    }

    return '${formatToDate(start)} - ${formatToDate(end)}';
  }

  /// Форматирование даты
  static String formatDate(DateTime dateTime) {
    if (dateTime == null) return null;
    return DateUtil.formatToDateDayMonthYear(dateTime)
        .replaceAll(' г.', emptyString);
  } // Обрезаем лишнее
}

/// Фоматирование для таймера
String formatSecondsToString(int seconds) {
  return seconds == null
      ? '00:00'
      : '00:${seconds < 10 ? '0$seconds' : seconds}';
}
