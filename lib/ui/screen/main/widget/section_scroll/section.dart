/// Модель секции данных.
class Section<T> {
  Section(this.name, this.items);

  final String name;
  final List<T> items;
}
