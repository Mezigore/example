import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uzhindoma/api/data/common/info_message.dart';
import 'package:uzhindoma/api/data/payment/payment_card.dart';
import 'package:uzhindoma/interactor/common/urls.dart';

part 'payment_client.g.dart';

@RestApi()
abstract class PaymentClient {
  factory PaymentClient(Dio dio, {String baseUrl}) = _PaymentClient;

  /// Получение карт пользователя
  @GET(PaymentUrls.cards)
  Future<List<PaymentCardData>> getCards();

  /// Удаление карты пользователя
  @DELETE(PaymentUrls.cardById)
  Future<InfoMessageData> deleteCardsId(@Path() String id);

  /// Установка дефолтной карты
  @PUT(PaymentUrls.cardById)
  Future<InfoMessageData> putCardsId(@Path() String id);
}
