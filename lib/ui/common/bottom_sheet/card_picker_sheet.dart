import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uzhindoma/domain/payment/payment_card.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Шторка с карты
class CardPickerSheet extends StatelessWidget {
  const CardPickerSheet({
    Key key,
    this.cards,
    this.currentCard,
  }) : super(key: key);

  /// Список карт пользователя
  final List<PaymentCard> cards;

  /// Текущая выюранная карта пользователя
  final PaymentCard currentCard;

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
                dialogSelectCardTitle,
                style: textMedium16,
              ),
            ),
            ...cards
                .map(
                  (card) => _CardTile(
                    card: card,
                    isSelected: card.id == currentCard?.id,
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

class _CardTile extends StatelessWidget {
  const _CardTile({
    Key key,
    this.card,
    this.isSelected,
  }) : super(key: key);
  final PaymentCard card;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(card),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                card.name,
                style: textRegular16,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isSelected)
              SvgPicture.asset(
                icSelected,
                height: 24,
                width: 24,
              ),
          ],
        ),
      ),
    );
  }
}
