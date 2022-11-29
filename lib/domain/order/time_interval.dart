/// Временные границы доставки
class TimeInterval {
  TimeInterval({
    this.from,
    this.to,
  });

  /// Время в формате ISO 8601 hh:mm
  final String from;

  /// Время в формате ISO 8601 hh:mm
  final String to;

  /// Заголовок в фомате from - to 9 - 12
  String _title;

  int _fromHour;
  int _toHour;

  int get fromHour {
    // ignore: avoid_returning_null
    if (from == null) return null;
    _fromHour ??= int.tryParse(from.substring(0, 2));
    return _fromHour;
  }

  int get toHour {
    // ignore: avoid_returning_null
    if (to == null) return null;
    _toHour ??= int.tryParse(to.substring(0, 2));
    return _toHour;
  }

  String get title {
    _title ??= fromHour == null || toHour == null
        ? '$from - $to'
        : '$fromHour - $toHour';
    return _title;
  }
}
