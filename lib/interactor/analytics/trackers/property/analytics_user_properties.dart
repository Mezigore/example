import 'package:uzhindoma/interactor/analytics/base/base_analytic_action.dart';
import 'package:uzhindoma/interactor/analytics/trackers/property/user_properties_events.dart';

/// Экшен аналитики данных пользователя
class AnalyticsUserProperties extends BaseAnalyticAction {
  /// Значение User Properties
  AnalyticsUserProperties({
    this.event,
    this.value,
  }) : super(event: event);

  final UserPropertyEvents event;

  final String value;
}
