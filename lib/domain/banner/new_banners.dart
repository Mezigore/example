import 'package:flutter/material.dart';

/// Модель данных для баннера на главном экране
class NewBanners {
  NewBanners({
    @required this.id,
    @required this.name,
    @required this.sort,
    @required this.image,
    @required this.type,
    @required this.value,
    @required this.size,
  })  : assert(id != null),
        assert(name != null),
        assert(sort != null),
        assert(image != null),
        assert(type != null),
        assert(size != null),
        assert(value != null);

  final String id;
  final String name;
  final String sort;
  final String image;
  final String type;
  final String value;
  final String size;
}
