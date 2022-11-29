import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uzhindoma/api/data/common/info_message.dart';
import 'package:uzhindoma/api/data/order/bonus.dart';
import 'package:uzhindoma/api/data/order/card_id.dart';
import 'package:uzhindoma/api/data/order/created_order.dart';
import 'package:uzhindoma/api/data/order/delivery_available.dart';
import 'package:uzhindoma/api/data/order/delivery_date.dart';
import 'package:uzhindoma/api/data/order/new_order.dart';
import 'package:uzhindoma/api/data/order/order_from_history.dart';
import 'package:uzhindoma/api/data/order/order_id.dart';
import 'package:uzhindoma/api/data/order/order_summ.dart';
import 'package:uzhindoma/api/data/order/order_updating.dart';
import 'package:uzhindoma/api/data/order/orders_history_rating.dart';
import 'package:uzhindoma/api/data/order/pay_system.dart';
import 'package:uzhindoma/api/data/order/promocode.dart';
import 'package:uzhindoma/interactor/common/urls.dart';

part 'order_client.g.dart';

@RestApi()
abstract class OrderClient {
  factory OrderClient(Dio dio, {String baseUrl}) = _OrderClient;

  /// Проверка доступности корзины для другого города. Сервер по отправленному городу проверяет доступность доставки
  @GET(OrderUrls.address)
  Future<DeliveryAvailableData> getAddress(@Query('city_id') String cityId);

  /// Создание заказа
  @POST(OrderUrls.create)
  Future<OrderIdData> postCreate(@Body() CreatedOrderData createdOrder);

  /// Оплата заказа картой
  @POST(OrderUrls.sumIdPay)
  Future<List<InfoMessageData>> postIdPay(
    @Path() String id,
    @Body() CardIdData cardID,
  );

  /// Инициализация сущности, которая используется для пересчета суммы заказа
  @POST(OrderUrls.order)
  Future<OrderSummData> postOrder();

  /// Получение времени и даты доставки
  @GET(OrderUrls.periods)
  Future<List<DeliveryDateData>> getPeriods(@Query('city') String city);

  /// Пересчет стоимости корзины при удалении бонусов
  @DELETE(OrderUrls.sumIdBonuses)
  Future<OrderSummData> deleteSummIdBonuses(@Path() String summId);

  /// Запрос бонусов, которые можно потратить за заказ
  @GET(OrderUrls.sumIdBonuses)
  Future<BonusData> getSummIdBonuses(@Path() String summId);

  /// Пересчет стоимости корзины при применении бонусов
  @POST(OrderUrls.sumIdBonuses)
  Future<OrderSummData> postSummIdBonuses(@Path() String summId);

  /// Отмена применения промокода
  @DELETE(OrderUrls.sumIdPromoCode)
  Future<OrderSummData> deleteSummIdPromocode(@Path() String summId);

  /// Валидация и применение промокода к заказу
  @POST(OrderUrls.sumIdPromoCode)
  Future<OrderSummData> postSummIdPromocode(
    @Path() String summId,
    @Body() PromoCodeData promocode,
  );

  /// Получение информации об истории заказов пользователя (за исключением новых заказов)
  @GET(OrderUrls.history)
  Future<List<OrderFromHistoryData>> getHistory();

  /// Получение информации о новых заказах
  @GET(OrderUrls.historyNew)
  Future<List<NewOrderData>> getHistoryNew();

  /// Получение времени и даты доставки для конкретного заказа (для изменения заказа)
  @GET(OrderUrls.idPeriods)
  Future<List<DeliveryDateData>> getIdPeriods(
    @Path() String id,
    @Query('city') String city,
  );

  /// Проставление оценок блюд для заказа
  @POST(OrderUrls.idRate)
  Future<InfoMessageData> postIdRate(
    @Path() String id,
    @Body() List<OrdersHistoryRatingData> ordersHistoryRaitings,
  );

  /// Восстановление заказа
  @POST(OrderUrls.idRestore)
  Future<InfoMessageData> postIdRestore(@Path() String id);

  /// Удаление заказа
  @DELETE(OrderUrls.orderId)
  Future<InfoMessageData> deleteOrderId(
    @Path() String id,
    @Body() String reason,
  );

  /// Изменение заказа
  @PATCH(OrderUrls.orderId)
  Future<InfoMessageData> patchOrderId(
    @Path() String id,
    @Body() OrderUpdatingData orderUpdating,
  );

  /// Оплата заказа через мобильные платежные системы (Google Pay, Apple Pay)
  @POST(OrderUrls.idPaySystems)
  Future<InfoMessageData> postIdPaySystems(
    @Path() String id,
    @Body() PaySystemData paySystem,
  );
}
