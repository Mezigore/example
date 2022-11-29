import 'package:uzhindoma/interactor/analytics/analytics.dart';
import 'package:uzhindoma/interactor/analytics/trackers/action/action_events.dart';
import 'package:uzhindoma/interactor/analytics/trackers/action/analytics_action.dart';

/// Класс с методами для отправки событий [ActionEvents]
class TrackerActions {
  TrackerActions(this._analytics);

  final Analytics _analytics;

  /// тестовый трекинг действия
  void trackDoAction() {
    _analytics.performAction(
      AnalyticsAction(
        event: ActionEvents.doAction,
      ),
    );
  }
}
