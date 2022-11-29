import 'package:uzhindoma/interactor/analytics/base/analytics_events.dart';

/// Тип событий User Properties налитики
class UserPropertyEvents extends AnalyticsEvents {
  const UserPropertyEvents(String value) : super(value);

  /// тестовое св-во пользователя
  static const testProperty = UserPropertyEvents('test_property');
}
