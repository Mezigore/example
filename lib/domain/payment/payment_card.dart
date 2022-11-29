/// Карта оплаты
class PaymentCard {
  PaymentCard({
    this.id,
    this.name,
    this.isDefault,
  });

  final String id;

  final String name;

  final bool isDefault;

  /// Не используются:
  /// id - не изменен
  /// name - содержит номер карты, менять его некорректно
  PaymentCard copyWith({bool isDefault}) {
    return PaymentCard(
      id: id,
      name: name,
      isDefault: isDefault ?? isDefault,
    );
  }
}
