import 'package:analytics/core/analytic_action.dart';
import 'package:uzhindoma/interactor/analytics/base/analytics_events.dart';

/// Базовый класс действия аналитики
abstract class BaseAnalyticAction extends AnalyticAction {
  BaseAnalyticAction({
    AnalyticsEvents event,
    this.params,
  }) : name = event.value;

  final String name;
  final Map<String, Object> params;
}
