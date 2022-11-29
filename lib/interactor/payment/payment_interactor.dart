import 'package:uzhindoma/domain/payment/payment_card.dart';
import 'package:uzhindoma/interactor/payment/payment_repository/payment_repository.dart';

/// Интерактор для работы с картами
class PaymentInteractor {
  PaymentInteractor(this._repository);

  final PaymentRepository _repository;

  /// Получить карты пользователя
  Future<List<PaymentCard>> getPaymentCards() => _repository.getPaymentCards();

  /// Обновить карточку по умолчанию
  Future<void> updateDefaultCard(String id) =>
      _repository.updateDefaultCard(id);

  /// Удалить карточку пользователя
  Future<void> deleteCard(String id) => _repository.deleteCard(id);
}
