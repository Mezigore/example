import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/widget/error/error.dart';

/// Виджет меню для состояния ошибки.
class PromoError extends StatelessWidget {
  const PromoError({
    Key key,
    @required this.onUpdate,
  })  : assert(onUpdate != null),
        super(key: key);

  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return ErrorStateWidget(
      onReloadAction: onUpdate,
    );
  }
}
