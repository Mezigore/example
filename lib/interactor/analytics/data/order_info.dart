/// Информация о заказе для аналитики
class OrderInfo {
  OrderInfo({this.isMobileOrder});
  OrderInfo.def() : isMobileOrder = true;

  /// Заказано ли с мобильного
  final bool isMobileOrder;
}
