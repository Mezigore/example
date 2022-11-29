import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/screen/main/widget/cards/card.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';

/// Виджет меню для состояния загрузки.
class PromoLoader extends StatelessWidget {
  const PromoLoader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Image(),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Title(),
              const SizedBox(height: 6),
              const _Title(),
              const SizedBox(height: 6),
              const _Line(width: 120),
              const SizedBox(height: 20),
              Row(
                children: const [
                  _Line(),
                  SizedBox(width: 20),
                  _Line(),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SkeletonWidget(
      isLoading: true,
      width: double.infinity,
      height: 12,
      radius: 16,
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    Key key,
    this.width = 64,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      isLoading: true,
      width: width,
      height: 12,
      radius: 16,
    );
  }
}

class _Image extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SkeletonWidget(
      isLoading: true,
      width: 128,
      height: 128,
      radius: 16,
    );
  }
}
