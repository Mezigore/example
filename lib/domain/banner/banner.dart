import 'package:flutter/material.dart';

/// Модель данных для баннера на главном экране
class Banner {
  Banner({
    @required this.id,
    @required this.imageUrl,
    @required this.url,
    @required this.title,
    @required this.description,
  })  : assert(id != null),
        assert(imageUrl != null),
        assert(url != null),
        assert(title != null),
        assert(description != null);

  final String id;

  /// url - для картинки: что будет подложкой для банера
  final String imageUrl;

  /// url - открываемая страница
  final String url;
  final String title;
  final String description;
}
