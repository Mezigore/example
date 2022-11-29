import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:uzhindoma/interactor/analytics/base/analytics_service.dart';

/// Класс для работы с аналитикой Firebase
class Firebase extends AnalyticsService {
  /// Экземпляр аналитики Firebasae
  static final FirebaseAnalytics _instance = FirebaseAnalytics.instance;

  static const userIdProperty = 'user_id';

  /// Устанавливает пользовательское свойство в указанное значение
  @override
  Future<void> setUserProperty({
    @required String name,
    @required String value,
  }) {
    return _instance.setUserProperty(name: name, value: value);
  }

  /// Отправить событие в Firebase
  @override
  void logEvent({String name, Map<String, Object> params}) {
    _instance.logEvent(
      name: name,
      parameters: params ?? AnalyticsService.defaultParams,
    );
  }

  @override
  void setUserId(String userId) {
    _instance.setUserId(id: userId);
  }
}
