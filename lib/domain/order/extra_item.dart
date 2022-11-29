/// Подарочный товар в корзине
class ExtraItem {
  ExtraItem({
    this.id,
    this.name,
    this.previewImg,
    this.price,
  });

  final String id;

  final String name;

  /// Ссылка на картинку для списка
  final String previewImg;

  /// Цена за товар
  final int price;
}
