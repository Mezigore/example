import 'package:uzhindoma/interactor/analytics/base/base_analytic_action.dart';
import 'package:uzhindoma/interactor/analytics/trackers/event/events.dart';

/// Экшен аналитики элементов экрана
class AnalyticsEvent extends BaseAnalyticAction {
  AnalyticsEvent({
    Events event,
    Map<String, Object> params,
  }) : super(event: event, params: params);
}
