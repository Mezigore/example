import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/order/rating_reason.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Шторка с выбором причин низкой оценки
class LowRateSheet extends StatelessWidget {
  const LowRateSheet({
    Key key,
    this.reasons,
  }) : super(key: key);

  /// Список карт пользователя
  final List<RatingReason> reasons;

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                rateLowTitle,
                style: textMedium16,
              ),
            ),
            ...reasons.map((reason) => _ReasonTile(reason: reason)).toList(),
          ],
        ),
      ),
    );
  }
}

class _ReasonTile extends StatelessWidget {
  const _ReasonTile({
    Key key,
    this.reason,
  }) : super(key: key);

  final RatingReason reason;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(reason),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                reason.title,
                style: textRegular16,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
