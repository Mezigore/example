import 'package:flutter/cupertino.dart';
import 'package:uzhindoma/util/date_formatter.dart';

/// Модель недели доступных для заказа.
/// [id] - Идентификатор недели
/// [startDate] - дата начала
/// [endDate] - дата окончания
/// [description] - Дополнительное описание к неделе
class WeekItem {
  WeekItem({
    @required this.id,
    this.startDate,
    this.endDate,
    this.description,
  }) : assert(id != null);

  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final String description;

  /// Вид: 27 сентября — 3 октября
  String get uiName {
    if (startDate != null && endDate != null) {
      return DateUtil.formatToDateRange(startDate, endDate);
    } else if (startDate != null || endDate != null) {
      return DateUtil.formatToDate(startDate ?? endDate);
    } else {
      return id;
    }
  }
}
