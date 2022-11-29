import 'package:surf_logger/surf_logger.dart';
import 'package:uzhindoma/interactor/analytics/base/analytics_service.dart';

/// Класс для работы с аналитикой Firebase
class DebugLogService extends AnalyticsService {
  /// Устанавливает пользовательское свойство в указанное значение
  @override
  Future<void> setUserProperty({
    String name,
    String value,
  }) async {
    Logger.d('ANALYTICS | user property - { name:$name, value:$value }');
  }

  /// Отправить событие в Firebase
  @override
  void logEvent({String name, Map<String, Object> params}) {
    Logger.d('ANALYTICS | event - { name:$name, params: $params }');
  }

  @override
  void setUserId(String userId) {
    Logger.d('ANALYTICS | userId: $userId');
  }
}
