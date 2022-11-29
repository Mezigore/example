import 'package:analytics/core/analytic_action.dart';
import 'package:analytics/core/analytic_action_performer.dart';
import 'package:flutter/foundation.dart';
import 'package:uzhindoma/interactor/analytics/analytics.dart';
import 'package:uzhindoma/interactor/analytics/base/base_analytic_action.dart';

/// Базовый класс для обработчиков события аналитики
abstract class BasePerformer<A extends BaseAnalyticAction>
    extends AnalyticActionPerformer<A> {
  BasePerformer(this.analytics);

  final Analytics analytics;

  @override
  bool canHandle(AnalyticAction action) => action is A;

  /// Метод для обработки [BaseAnalyticAction]
  @override
  void perform(A action) {
    _logEvent(name: action.name, params: action.params);
  }

  /// Метод отправки событий в аналитики
  void _logEvent({
    @required String name,
    Map<String, Object> params,
  }) {
    assert(name != null);
    for (final service in analytics.services) {
      service.logEvent(name: name, params: params);
    }
  }
}
