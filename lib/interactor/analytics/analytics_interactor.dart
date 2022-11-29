import 'package:uzhindoma/interactor/analytics/analytics.dart';
import 'package:uzhindoma/interactor/analytics/base/analytics_observer.dart';
import 'package:uzhindoma/interactor/analytics/trackers/action/tracker_actions.dart';
import 'package:uzhindoma/interactor/analytics/trackers/event/tracker_events.dart';
import 'package:uzhindoma/interactor/analytics/trackers/property/tracker_user_property.dart';

/// Интерактор для отправления события в Аналитику
class AnalyticsInteractor {
  AnalyticsInteractor(this._analytics)
      : property = TrackerUserProperty(_analytics),
        events = TrackerEvents(_analytics),
        actions = TrackerActions(_analytics) {
    AnalyticsNavigationObserver.onOpenCatalog = events.trackOpenCatalogScreen;
  }

  final Analytics _analytics;

  /// Трекер для св-в пользователя
  final TrackerUserProperty property;

  /// Трекер для событий
  final TrackerEvents events;

  /// Трекер для действий
  final TrackerActions actions;

  /// установить id пользователя
  void setUserId(String userId) {
    _analytics.setUserId(userId);
  }
}
