import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/payment/payment_card.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/widgets/order_tap_field.dart';
import 'package:uzhindoma/util/const.dart';

/// Виджет для выбора способа оплаты и карты
class SelectCardBlock extends StatelessWidget {
  const SelectCardBlock({
    Key key,
    this.onCardTap,
    this.onAddCard,
    this.currentCard,
    this.cardsState,
  }) : super(key: key);

  final VoidCallback onCardTap;
  final VoidCallback onAddCard;
  final PaymentCard currentCard;
  final EntityStreamedState<List<PaymentCard>> cardsState;

  @override
  Widget build(BuildContext context) {
    return EntityStateBuilder<List<PaymentCard>>(
      streamedState: cardsState,
      loadingChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          OrderTapField(
            isLoading: true,
            onTap: onCardTap,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: null,
            child: Text(createOrderAddCard, style: textMedium16Accent),
          )
        ],
      ),
      errorBuilder: (_, list, error) => _CardWidgetChild(
        currentCard: currentCard,
        onCardTap: onCardTap,
        onAddCard: onAddCard,
        needShowCardPicker: list != null && list.isNotEmpty,
      ),
      child: (_, list) => _CardWidgetChild(
        currentCard: currentCard,
        onCardTap: onCardTap,
        onAddCard: onAddCard,
        needShowCardPicker: list != null && list.isNotEmpty,
      ),
    );
  }
}

class _CardWidgetChild extends StatelessWidget {
  const _CardWidgetChild({
    Key key,
    @required this.currentCard,
    @required this.onCardTap,
    @required this.onAddCard,
    this.needShowCardPicker = false,
  }) : super(key: key);

  final PaymentCard currentCard;
  final VoidCallback onCardTap;
  final VoidCallback onAddCard;
  final bool needShowCardPicker;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (needShowCardPicker) const SizedBox(height: 16),
        if (needShowCardPicker)
          OrderTapField(
            text: currentCard?.name ?? emptyString,
            onTap: onCardTap,
          ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: onAddCard,
          child: Text(createOrderAddCard, style: textMedium16Accent),
        )
      ],
    );
  }
}
