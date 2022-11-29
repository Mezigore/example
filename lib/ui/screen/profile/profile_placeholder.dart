import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/screen/profile/profile_screen.dart';

/// Экран загрузки для [ProfileScreen]
class ProfilePlaceholder extends StatelessWidget {
  const ProfilePlaceholder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 32),
            SkeletonWidget(
              height: 28,
              width: 104,
              radius: 16,
              isLoading: true,
            ),
            SizedBox(height: 11),
            _FlexSkeleton(flex: 8, height: 12),
            SizedBox(height: 27),
            _WideSkeleton(),
            SizedBox(height: 16),
            _WideSkeleton(),
            SizedBox(height: 16),
            _WideSkeleton(),
            SizedBox(height: 12),
            _FlexSkeleton(flex: 8, height: 8),
            SizedBox(height: 8),
            _FlexSkeleton(flex: 3, height: 8),
            SizedBox(height: 20),
            _WideSkeleton(),
            SizedBox(height: 12),
            _FlexSkeleton(flex: 8, height: 8),
            SizedBox(height: 46),
            SkeletonWidget(
              height: 28,
              width: 104,
              radius: 16,
              isLoading: true,
            ),
            SizedBox(height: 11),
            _FlexSkeleton(flex: 8, height: 12),
            SizedBox(height: 27),
            _WideSkeleton(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _FlexSkeleton extends StatelessWidget {
  const _FlexSkeleton({
    Key key,
    @required this.flex,
    @required this.height,
  }) : super(key: key);

  final int flex;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: flex,
          child: SkeletonWidget(
            height: height,
            radius: 16,
            isLoading: true,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _WideSkeleton extends StatelessWidget {
  const _WideSkeleton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SkeletonWidget(
      height: 56,
      width: double.infinity,
      radius: 12,
      isLoading: true,
    );
  }
}

class SkeletonAppBar extends StatelessWidget {
  const SkeletonAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16.0, left: 12, right: 12),
      child: SkeletonWidget(
        isLoading: true,
        height: 15,
        radius: 9,
        width: double.infinity,
      ),
    );
  }
}
