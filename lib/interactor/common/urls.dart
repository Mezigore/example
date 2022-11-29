import 'package:uzhindoma/config/config.dart';
import 'package:uzhindoma/config/env/env.dart';

///URL запросов сервера
abstract class Url {
  static String get prodProxyUrl => '';

  static String get qaProxyUrl => '';

  static String get devProxyUrl => '';

  static String get testUrl =>
      'https://uzhindoma.shmelev.w.ibrush.ru$_urlAddition';

  // static String get prodUrl =>
  //     'https://uzhindoma-25854.romanov.w.ibrush.ru$_urlAddition';

  static String get prodUrl => 'https://uzhindoma.ru$_urlAddition';

  static String get devUrl => 'https://localhost:9999/food/hs/ExchangeSotr';

  static String get baseUrl => Environment<Config>.instance().config.url;

  static String get _urlAddition => '/rest';
}

class AppsApiUrl {
  static const String _base = '/apps';

  ///Получение номера последней версии приложения
  static const String versions = '$_base/versions';
}

class CatalogApiUrl {
  static const String _base = '/catalog';

  /// Получение меню
  static const String menu = _base;

  /// Получение списка недель по городу
  static const String recommend = '$_base/recommend?userID={id}';

 /// Получение промо набора
  static const String promo = '$_base/promoApp';

  /// Получение списка недель по городу
  static const String weeks = '$_base/weeks';

  /// Получение списка доступных городов
  static const String cities = '$_base/cities';

  /// Получение города по координатам
  static const String citiesByPosition = '$cities/preferred';
}

class CartApiUrl {
  static const String _base = '/cart';

  /// Получение корзины
  static const String getCart = _base;

  /// Получение корзины
  static const String getPromoCart = '$_base?promoname=promoname';

  /// Добавление в корзину
  static const String addToCart = _base;

  /// Удаление из корзины
  static const String removeFromCart = _base;

  /// Очистка корзины
  static const String clearCart = '$_base/clear';

  /// Удаление подарка
  static const String removeExtra = '$_base/extra';

  ///Добавление промо-набора
  static const String addPromo = '$_base/addPromo';
}

class BannerApiUrl {
  static const String _base = '/banners';

  /// Получение баннеров
  static const String getBanners = _base;

  /// Получение новых баннеров
  static const String getNewBanners = '$_base/app';
}


class UserApiUrls {
  static const String _base = '/user';

  /// Обновление телефона
  static const String changePhone = '$_base/changePhone';

  /// Подтверждение обновления телефона
  static const String conformChangePhone = '$_base/conformChangePhone';

  /// Работа с любимыми блюдами
  static const String favourite = '$_base/favourite';

  /// Работа с информацией о пользователе
  static const String profile = '$_base/profile';

  /// Удаление пользователя
  static const String deleteAccount = '$_base/delete';

  /// Возвращает количество заказов пользователя
  static const String ordersCount = '$_base/ordersCount';
}

class AddressesUrls {
  AddressesUrls._();

  static const String _base = '/addresses';

  static const String addresses = _base;
  static const String addressById = '$_base/{id}';
  static const String search = '$_base/search';
}

class PaymentUrls {
  PaymentUrls._();

  static const String _base = '/cards';

  static const String cards = _base;
  static const String cardById = '$_base/{id}';

  static String get _baseCardUrl => Url.baseUrl.substring(
        0,
        Url.baseUrl.indexOf(Url._urlAddition),
      );

  static String addCardToUser(String userId) {
    return '$_baseCardUrl/card/?user_id=$userId';
  }

  static String payOrder(String orderId) {
    return '$_baseCardUrl/order_pay/?order_id=$orderId';
  }
}

class AuthApiUrls {
  static const String _base = '/auth';

  /// Метод установки контакта с сервером
  static const String checkIn = '$_base/checkIn';

  /// Метод для отправки контакта на сервер
  static const String sendCode = '$_base/sendCode';

  /// Метод для отправки контакта и кода подтверждения на сервер
  static const String checkCode = '$_base/checkCode';

  /// Обновление токена
  static const String exchangeToken = '/exchangeToken';
}

class OrderUrls {
  OrderUrls._();

  static const String _base = '/order';

  static const String order = _base;
  static const String create = '$_base/create';
  static const String address = '$_base/address';
  static const String sumIdBonuses = '$_base/{summId}/bonuses';
  static const String sumIdPay = '$_base/{id}/pay';
  static const String sumIdPromoCode = '$_base/{summId}/promocode';
  static const String periods = '$_base/periods';

  /// Оплата через Google/Apple Pay
  static const String idPaySystems = '$_base/{id}/pay_systems';

  /// Получение информации об истории заказов пользователя
  static const String history = '/order/history';

  /// Получение информации о новых заказах
  static const String historyNew = '/order/history/new';

  /// Получение времени и даты доставки для конкретного заказа
  static const String idPeriods = '/order/{id}/periods';

  /// Проставление оценок блюд для заказа
  static const String idRate = '/order/{id}/rate';

  /// Восстановление заказа
  static const String idRestore = '/order/{id}/restore';

  /// Взаимодействие с заказом - удаление, изменение
  static const String orderId = '/order/{id}';
}

class RecipesUrls {
  RecipesUrls._();

  static const String _base = '/recipes';

  /// Получение новых рецептов пользователя
  static const String newRecipes = '$_base/new';

  /// Получение любимых рецептов пользователя
  static const String likeRecipes = '$_base/favorite';

  /// Получение всех рецептов пользователя
  static const String recipes = _base;

  /// Изменение статуса рецепта
  static const String recipeById = '$_base/{id}';

  /// добавить в лайкнутые: GET: /rest/recipes/like/{product_id}
  static const String recipeLike = '$_base/like/{id}';

  ///удалить из лайкнутых: GET: /rest/recipes/unlike/{product_id}
  static const String recipeUnlike = '$_base/unlike/{id}';
}
