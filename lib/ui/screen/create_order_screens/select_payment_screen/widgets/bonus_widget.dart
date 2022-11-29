import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Виджет для отображения бонуса
class BonusWidget extends StatelessWidget {
  const BonusWidget({
    Key key,
    bool hasError,
    bool isLoading,
    @required this.bonuses,
  })  : isLoading = isLoading ?? false,
        hasError = hasError ?? false,
        assert(
          isLoading == null && hasError == null && bonuses != null ||
              isLoading != null && isLoading ||
              hasError != null && hasError,
        ),
        super(key: key);

  final bool hasError;
  final bool isLoading;
  final int bonuses;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: isLoading
          ? const SkeletonWidget(
              height: 24,
              width: 40,
              isLoading: true,
              radius: 4,
            )
          : hasError
              ? const SkeletonWidget(
                  height: 24,
                  width: 40,
                  radius: 4,
                )
              : Container(
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  child: Text(
                    bonuses.toString(),
                    style: textMedium14,
                  ),
                ),
    );
  }
}
