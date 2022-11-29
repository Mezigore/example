/// Интерфейс для элементов корзины.
/// [id] - идентификатор блюда.
/// [ratio] - количество порций для операции за раз.
abstract class CartElement {
  String get id;
  int get ratio;
}
