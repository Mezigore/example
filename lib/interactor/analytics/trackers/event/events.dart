import 'package:uzhindoma/interactor/analytics/base/analytics_events.dart';
import 'package:uzhindoma/interactor/analytics/data/order_info.dart';

/// Тип событий
class Events extends AnalyticsEvents {
  const Events(String value) : super(value);

  /// Отсылается при каждом входе в приложение
  static const doAppOpen = Events('app_open');

  /// По тапу на "Оформить заказ"
  static const doCheckoutStart = Events('action_checkout_start');

  /// По тапу на "Оформить заказ"
  static const doProfileAdded = Events('checkout_profile_added');

  /// По успешному указанию адреса доставки
  static const doAddressAdded = Events('checkout_address_added');

  /// По успешному выбору даты и времени доставки
  static const doDateAdded = Events('checkout_date_added');

  /// По успешному ответу от сервера об оформлении заказа
  static const doCheckoutComplete = Events('checkout_complete');

  /// По успешному ответу об оплате (через google и apple pay)
  static const doPaymentSystemSuccess = Events('checkout_payment_complete');

  /// Открытие экрана корзины по тапу на кнопку перехода к корзине
  static const doOpenCartScreen = Events('action_cart');

  /// Открытие экрана каталога
  static const doOpenCatalog = Events('view_open_catalog');

  ///Успешная авторизация
  static const doAuthSuccess = Events('auth_success');

  ///Просмотр экрана бонусов
  static const doOpenBonus = Events('bonus_view');

  ///Нажатие на кнопку Поделиться
  static const doBonusClick = Events('bonus_click');

  ///Просмотр экрана промо-набора
  static const doOpenPromo = Events('promo_view');

}

extension OrderInfoExt on OrderInfo {
  /// данные для [Events.doCheckoutComplete]
  Map<String, Object> toMap() {
    return {
      'mobile_order': isMobileOrder,
    };
  }
}
