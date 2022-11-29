import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/order/order_summ.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Виджет для отображение итоговой суммы заказа
class SumWidget extends StatelessWidget {
  const SumWidget({
    Key key,
    @required this.sum,
    this.count,
  })  : assert(sum != null),
        super(key: key);

  final OrderSum sum;
  final int count; // количество блюд в заказе

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(fullPriceTitle, style: textRegular16),
            Text(sum.totalPriceTitle, style: textRegular16),
          ],
        ),
        if (sum.discountCountTitle != null) const SizedBox(height: 12),
        if (sum.discountCountTitle != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$discountCountTitle $count ${mainDishesPlural(count)}',
                  style: textRegular16),
              Text(sum.discountCountTitle, style: textRegular16),
            ],
          ),
        if (sum.discountSummTitle != null) const SizedBox(height: 12),
        if (sum.discountSummTitle != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(discountTitle, style: textRegular16),
              Text(sum.discountSummTitle, style: textRegular16),
            ],
          ),
        if (sum.bonusTitle != null) const SizedBox(height: 12),
        if (sum.bonusTitle != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bonusesTitle, style: textRegular16),
              Text(sum.bonusTitle, style: textRegular16),
            ],
          ),
        if (sum.promoCodeTitle != null) const SizedBox(height: 12),
        if (sum.promoCodeTitle != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(promoCodeTitle, style: textRegular16),
              Text(sum.promoCodeTitle, style: textRegular16),
            ],
          ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(priceTitle, style: textMedium24),
            Text(sum.priceWithDiscountTitle, style: textMedium24),
          ],
        ),
      ],
    );
  }
}
