import 'package:uzhindoma/domain/order/delivery_time_interval.dart';
import 'package:uzhindoma/util/date_formatter.dart';

/// Дата и время доставки
class DeliveryDate {
  DeliveryDate({
    this.date,
    this.time,
  });

  /// Дата в формате ISO 8601 "yyyy-MM-dd"
  final String date;

  final List<DeliveryTimeInterval> time;

  DateTime _date;
  String _dateTitle;

  DateTime get dateTime {
    _date ??= DateTime.tryParse(date);
    return _date;
  }

  /// Вид: 22 сентября, ПН
  String get dateTitle {
    _dateTitle ??= DateUtil.formatDayMonthDayWeek(dateTime);
    return _dateTitle;
  }
}
