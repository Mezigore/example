import 'package:flutter/widgets.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';

/// Заглушка адреса в списке
class AddressTilePlaceholder extends StatelessWidget {
  const AddressTilePlaceholder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        SkeletonWidget(
          height: 12,
          width: 296,
          isLoading: true,
          borderRadius: BorderRadius.circular(16),
        ),
        const SizedBox(height: 8),
        SkeletonWidget(
          height: 12,
          width: 227,
          isLoading: true,
          borderRadius: BorderRadius.circular(16),
        ),
        const SizedBox(height: 16),
        SkeletonWidget(
          height: 12,
          width: 104,
          isLoading: true,
          borderRadius: BorderRadius.circular(16),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
