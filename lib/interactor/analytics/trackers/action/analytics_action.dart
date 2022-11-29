import 'package:uzhindoma/interactor/analytics/base/base_analytic_action.dart';
import 'package:uzhindoma/interactor/analytics/trackers/action/action_events.dart';

/// Экшен аналитики действия
class AnalyticsAction extends BaseAnalyticAction {
  AnalyticsAction({
    ActionEvents event,
    Map<String, Object> params,
  }) : super(event: event, params: params);
}
