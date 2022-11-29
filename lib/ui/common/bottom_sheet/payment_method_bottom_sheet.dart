import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/order/payment_type.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Шторка с выбором метода оплаты
class PaymentMethodSheet extends StatelessWidget {
  const PaymentMethodSheet({
    Key key,
    this.methods,
  }) : super(key: key);

  /// Список способов оплаты
  final List<PaymentType> methods;

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                dialogSelectPaymentMethod,
                style: textMedium16,
              ),
            ),
            ...methods.map((m) => _PaymentMethodTile(method: m)).toList(),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  const _PaymentMethodTile({
    Key key,
    this.method,
  }) : super(key: key);
  final PaymentType method;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(method),
      child: Row(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Text(
              method.title,
              style: textRegular16,
            ),
          ),
        ],
      ),
    );
  }
}
