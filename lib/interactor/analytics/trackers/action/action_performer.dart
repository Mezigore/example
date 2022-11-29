import 'package:uzhindoma/interactor/analytics/analytics.dart';
import 'package:uzhindoma/interactor/analytics/base/base_performer.dart';
import 'package:uzhindoma/interactor/analytics/trackers/action/analytics_action.dart';

/// Перформер для обработки событий аналитики [AnalyticsAction]
class ActionPerformer extends BasePerformer<AnalyticsAction> {
  ActionPerformer(Analytics analytics) : super(analytics);
}
