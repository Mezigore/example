import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Виджет для отображение итоговой суммы заказа
class CartSumWidget extends StatelessWidget {
  const CartSumWidget({
    Key key,
    @required this.fullPrice,
    @required this.priceWithDiscount,
    this.discount,
    this.discountSumm,
    this.discountCountSumm,
    this.count,
  })  : assert(fullPrice != null),
        assert(priceWithDiscount != null),
        super(key: key);

  final String fullPrice;
  final String priceWithDiscount;
  final String discount;
  final String discountSumm; // скидка Ужин Дома Family
  final String discountCountSumm; // скидка за количество
  final String count; // количество блюд в корзине

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (discountCountSumm != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ваша скидка', style: textMedium18),
              Text(discountCountSumm, style: textRegular16),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric( vertical: 24),
            child: Divider(thickness: 1, color: dividerLightColor),
          ),
        ],
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(fullPriceTitle, style: textRegular16),
        //     Text(fullPrice, style: textRegular16),
        //   ],
        // ),
        //
        // if (discountSumm != null) ...[
        //   const SizedBox(height: 12),
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(discountTitle, style: textRegular16),
        //       Text(discountSumm, style: textRegular16),
        //     ],
        //   ),
        // ],
        // const SizedBox(height: 12),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(priceTitle, style: textMedium18.copyWith(height: 0.5)),
            const Expanded(child: DottedLine(dashLength: 2,)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
              if (discountCountSumm != null) ...[
                Text(
                  fullPrice,
                  style: textRegular16.copyWith(decoration: TextDecoration.lineThrough, fontSize: 18, color: textColorSecondary, height: 0.5)
                ),],
                const SizedBox(width: 14,),
                Text(priceWithDiscount, style: textMedium24.copyWith(height: 0.37) ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
