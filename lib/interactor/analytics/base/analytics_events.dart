import 'package:surf_util/surf_util.dart';

/// Базовый класс типа события налитики
abstract class AnalyticsEvents extends Enum<String> {
  const AnalyticsEvents(String value) : super(value);
}
