import 'package:uzhindoma/interactor/analytics/analytics.dart';
import 'package:uzhindoma/interactor/analytics/base/base_performer.dart';
import 'package:uzhindoma/interactor/analytics/trackers/event/analytics_event.dart';

/// Перформер для обработки событий элементов экрана
class EventPerformer extends BasePerformer<AnalyticsEvent> {
  EventPerformer(Analytics analytics) : super(analytics);
}
