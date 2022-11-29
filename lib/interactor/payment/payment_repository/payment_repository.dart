import 'package:uzhindoma/api/client/payment/payment_client.dart';
import 'package:uzhindoma/domain/payment/payment_card.dart';
import 'package:uzhindoma/interactor/payment/payment_repository/payment_mappers.dart';

/// Интерактор для работы с картами
class PaymentRepository {
  PaymentRepository(this._client);

  final PaymentClient _client;

  /// Получить карты пользователя
  Future<List<PaymentCard>> getPaymentCards() async {
    final cards = await _client.getCards();
    return cards.map(mapPaymentCard).toList();
  }

  /// Обновить карточку по умолчанию
  Future<void> updateDefaultCard(String id) async {
    await _client.putCardsId(id);
  }

  /// Удалить карточку пользователя
  Future<void> deleteCard(String id) async {
    await _client.deleteCardsId(id);
  }
}
