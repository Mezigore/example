import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/order/order_change_enum.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Шторка с выбором изменений в заказе
class ChangeOrderSheet extends StatelessWidget {
  const ChangeOrderSheet({
    Key key,
    this.changes,
  }) : super(key: key);

  /// Список карт пользователя
  final List<OrderChanges> changes;

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
                orderChange,
                style: textMedium16,
              ),
            ),
            ...changes.map((change) => _ChangeTile(change: change)).toList(),
          ],
        ),
      ),
    );
  }
}

class _ChangeTile extends StatelessWidget {
  const _ChangeTile({
    Key key,
    this.change,
  }) : super(key: key);
  final OrderChanges change;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(change),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                change.title,
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
