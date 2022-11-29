/// Базовый класс для сервисов аналитики
abstract class AnalyticsService {
  static const defaultParams = <String, String>{};

  /// Отправить событие в сервис аналитики
  void logEvent({String name, Map<String, Object> params});

  /// Отправить св-ва пользователя
  void setUserProperty({String name, String value});

  /// установить id пользователя
  void setUserId(String userId);
}
