import 'package:analytics/core/analytic_action.dart';
import 'package:analytics/core/analytic_action_performer.dart';
import 'package:analytics/core/analytic_service.dart';
import 'package:analytics/impl/default_analytic_service.dart';
import 'package:uzhindoma/interactor/analytics/base/analytics_service.dart';
import 'package:uzhindoma/interactor/analytics/remotes/firebase.dart';
import 'package:uzhindoma/interactor/analytics/trackers/action/action_performer.dart';
import 'package:uzhindoma/interactor/analytics/trackers/event/event_performer.dart';
import 'package:uzhindoma/interactor/analytics/trackers/property/user_properties_performer.dart';

/// Класс для работы с Аналитикой приложения
class Analytics {
  Analytics() {
    _init();
  }

  /// Список сервисов аналитики
  final services = <AnalyticsService>{
    Firebase(),
  };

  /// Сервис запускающий [AnalyticActionPerformer]
  final analyticsService = DefaultAnalyticService();

  /// Добавить обработчика [AnalyticActionPerformer]
  /// в [AnalyticService] для обработки [AnalyticAction]
  DefaultAnalyticService addPerformer(
    AnalyticActionPerformer<AnalyticAction> performer,
  ) =>
      analyticsService.addActionPerformer(performer);

  /// Обработать [AnalyticAction] соответствующим [AnalyticActionPerformer]
  void performAction(AnalyticAction action) =>
      analyticsService.performAction(action);

  /// установить id пользователя
  void setUserId(String userId) {
    for (final service in services) {
      service.setUserId(userId);
    }
  }

  void _init() {
    _initPerformers();
  }

  void _initPerformers() {
    addPerformer(ActionPerformer(this));
    addPerformer(EventPerformer(this));
    addPerformer(UserPropertiesPerformer(this));
  }
}
