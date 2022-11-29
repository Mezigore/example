import 'package:flutter/cupertino.dart';

const moscowId = '84';

/// Модель данных города
/// [id] - идентификатор города
/// [name] - название города
class CityItem {
  const CityItem({
    @required this.id,
    @required this.name,
  })  : assert(id != null),
        assert(name != null);

  static const emptyCity = CityItem(id: '', name: '');

  final String id;
  final String name;

  @override
  String toString() {
    return 'CityItem{id: $id, name: $name}';
  }

  CityItem copyWith({String name}) {
    return CityItem(
      id: id,
      name: name ?? this.name,
    );
  }
}
