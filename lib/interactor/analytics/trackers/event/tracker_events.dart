import 'package:uzhindoma/interactor/analytics/analytics.dart';
import 'package:uzhindoma/interactor/analytics/data/order_info.dart';
import 'package:uzhindoma/interactor/analytics/trackers/event/analytics_event.dart';
import 'package:uzhindoma/interactor/analytics/trackers/event/events.dart';

/// Класс с методами для отправки событий
class TrackerEvents {
  TrackerEvents(this._analytics);

  final Analytics _analytics;

  /// Событие открытие приложения
  void trackAppOpen() {
    _analytics.performAction(
      AnalyticsEvent(event: Events.doAppOpen),
    );
  }

  /// Событие ро тапу на "Оформить заказ"
  void trackCheckoutStart() {
    _analytics.performAction(
      AnalyticsEvent(event: Events.doCheckoutStart),
    );
  }

  /// Событие по тапу на "Оформить заказ"
  void trackProfileAdded() {
    _analytics.performAction(
      AnalyticsEvent(event: Events.doProfileAdded),
    );
  }

  /// Событие по успешному указанию адреса доставки
  void trackAddressAdded() {
    _analytics.performAction(
      AnalyticsEvent(event: Events.doAddressAdded),
    );
  }

  /// Событие по успешному выбору даты и времени доставки
  void trackDateAdded() {
    _analytics.performAction(
      AnalyticsEvent(event: Events.doDateAdded),
    );
  }

  /// Событие по успешному ответу от сервера об оформлении заказа
  void trackCheckoutComplete() {
    _analytics.performAction(
      AnalyticsEvent(
        event: Events.doCheckoutComplete,
        params: OrderInfo.def().toMap(),
      ),
    );
  }

  /// Событие по успешному ответу об оплате (через google и apple pay)
  void trackPaymentSystemSuccess() {
    _analytics.performAction(
      AnalyticsEvent(event: Events.doPaymentSystemSuccess),
    );
  }

  /// Событие открытие экрана корзины по тапу на кнопку перехода к корзине
  void trackOpenCartScreen() {
    _analytics.performAction(
      AnalyticsEvent(event: Events.doOpenCartScreen),
    );
  }

  /// Событие открытие экрана корзины по тапу на кнопку перехода к корзине
  void trackOpenCatalogScreen() {
    _analytics.performAction(
      AnalyticsEvent(event: Events.doOpenCatalog),
    );
  }

  /// Событие успешной авторизации, переход к главному экрану
  void trackAuthSuccess() {
    _analytics.performAction(
      AnalyticsEvent(event: Events.doAuthSuccess),
    );
  }

  /// Событие открытие экрана Бонусов
  void trackOpenBonusScreen() {
    _analytics.performAction(
      AnalyticsEvent(event: Events.doOpenBonus),
    );
  }

  /// Событие нажатие кнопки "Поделиться" на экране Бонусов
  void trackBonusButtonClick() {
    _analytics.performAction(
      AnalyticsEvent(event: Events.doBonusClick),
    );
  }

  /// Событие открытие экрана промо-набор
  void trackOpenPromoScreen() {
    _analytics.performAction(
      AnalyticsEvent(event: Events.doOpenPromo),
    );
  }


}
