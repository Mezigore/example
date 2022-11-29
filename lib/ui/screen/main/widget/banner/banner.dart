import 'package:flutter/material.dart';

/// Виджет отображения баннеров.
class AdvBanner extends StatelessWidget {
  const AdvBanner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      automaticallyImplyLeading: false,
      title: Placeholder(
        fallbackHeight: 50,
        fallbackWidth: double.infinity,
      ),
    );
  }
}
