import 'package:uzhindoma/interactor/analytics/analytics.dart';
import 'package:uzhindoma/interactor/analytics/trackers/property/analytics_user_properties.dart';
import 'package:uzhindoma/interactor/analytics/trackers/property/user_properties_events.dart';

/// Класс с методами для отправки событий [UserPropertyEvents]
class TrackerUserProperty {
  TrackerUserProperty(this._analytics);

  final Analytics _analytics;

  /// отправка св-ва о разрешении на геопозиции
  void trackTestProperty() {
    _analytics.performAction(
      AnalyticsUserProperties(
        event: UserPropertyEvents.testProperty,
        value: 'test',
      ),
    );
  }
}
