import 'package:uzhindoma/api/client/order/order_client.dart';
import 'package:uzhindoma/api/data/order/card_id.dart';
import 'package:uzhindoma/api/data/order/created_order.dart';
import 'package:uzhindoma/api/data/order/promocode.dart';
import 'package:uzhindoma/domain/order/bonus.dart';
import 'package:uzhindoma/domain/order/delivery_available.dart';
import 'package:uzhindoma/domain/order/delivery_date.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/domain/order/order_from_history.dart';
import 'package:uzhindoma/domain/order/order_summ.dart';
import 'package:uzhindoma/domain/order/order_updating.dart';
import 'package:uzhindoma/domain/order/orders_history_raiting.dart';
import 'package:uzhindoma/domain/order/pay_system.dart';
import 'package:uzhindoma/interactor/order/order_repository/order_mappers.dart';

/// Репозиторий для работы с заказом
class OrderRepository {
  OrderRepository(this._client);

  final OrderClient _client;

  /// Создание заказа
  Future<String> createOrder(CreatedOrderData data) async {
    final orderIdData = await _client.postCreate(data);
    return mapOrderId(orderIdData).id;
  }

  /// Проверка доступности доставки в другом городе
  Future<DeliveryAvailable> checkDeliveryAvailableByCityId(
    String cityId,
  ) async {
    final data = await _client.getAddress(cityId);
    return mapDeliveryAvailable(data);
  }

  /// Получить количество бонусов, которые можно списать для заказа
  Future<Bonus> getBonus(String sumId) async {
    final data = await _client.getSummIdBonuses(sumId);
    return mapBonus(data);
  }

  /// Удалить бонусы
  Future<OrderSum> removeBonuses(String sumId) async {
    final data = await _client.deleteSummIdBonuses(sumId);
    return mapOrderSum(data);
  }

  /// Добавить бонусы к заказу
  Future<OrderSum> addBonus(String sumId) async {
    final data = await _client.postSummIdBonuses(sumId);
    return mapOrderSum(data);
  }

  /// Оплатить заказ картой
  Future<void> payWithCard(String orderId, CardIdData cardId) async {
    await _client.postIdPay(orderId, cardId);
  }

  /// Удалить промокод из заказа
  Future<OrderSum> removePromoCode(String sumId) async {
    final data = await _client.deleteSummIdPromocode(sumId);
    return mapOrderSum(data);
  }

  /// Добавить промокод к заказу
  Future<OrderSum> addPromoCode(String sumId, PromoCodeData promoCode) async {
    final data = await _client.postSummIdPromocode(sumId, promoCode);
    return mapOrderSum(data);
  }

  /// Инициализировать заказ
  Future<OrderSum> initOrder() async {
    final data = await _client.postOrder();
    return mapOrderSum(data);
  }

  /// Получить даты и время доставки
  Future<List<DeliveryDate>> getDeliveryDateList(String cityId) async {
    final data = await _client.getPeriods(cityId);
    return data.map(mapDeliveryDate).toList();
  }

  /// Получение информации об истории заказов пользователя
  Future<List<OrderFromHistory>> getOrderHistoryList() async {
    final data = await _client.getHistory();
    return data.map(mapOrderFromHistory).toList();
  }

  /// Получение информации о новых заказах
  Future<List<NewOrder>> getActualOrderList() async {
    final data = await _client.getHistoryNew();
    return data.map(mapNewOrder).toList();
  }

  /// Получение времени и даты доставки для конкретного заказа
  Future<List<DeliveryDate>> getDeliveryDateListById(
    String id,
    String city,
  ) async {
    final data = await _client.getIdPeriods(id, city);
    return data.map(mapDeliveryDate).toList();
  }

  /// Оценка блюд из заказа
  Future<void> rateOrder(
    String id,
    List<OrdersHistoryRating> ordersHistoryRatings,
  ) {
    return _client.postIdRate(
      id,
      ordersHistoryRatings.map(mapOrdersHistoryRatingData).toList(),
    );
  }

  /// Восстановление заказа
  Future<void> restoreOrder(String id) {
    return _client.postIdRestore(id);
  }

  /// Отмена заказа
  Future<void> cancelOrder(String id, String reason) {
    return _client.deleteOrderId(id, reason);
  }

  /// Изменение заказа
  Future<void> editOrder(String id, OrderUpdating orderUpdating) {
    return _client.patchOrderId(id, mapOrderUpdatingData(orderUpdating));
  }

  /// Оплата через нативную систему оплаты
  Future<void> payOrderWithPaymentSystem(
    String id,
    PaySystem paymentSystem,
  ) async {
    final data = mapPaySystemData(paymentSystem);
    await _client.postIdPaySystems(id, data);
  }
}
