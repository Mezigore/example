import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';


class DiscountWidget extends StatelessWidget{
  DiscountWidget({ Key key,
    // @required this.minCount,
    // @required this.maxCount,
    // @required this.currentCount,
    @required this.discount,
  }) : super(key: key);
  // final int minCount;
  // final int maxCount;
  // final int currentCount;
  final int discount;

  DefaultDialogController _dialogController;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Ужин дома Family',
                  style: textRegular16,
                ),
                const SizedBox(width: 8,),
                GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet<bool>(
                        context: context,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        builder: (_) => BottomSheetContainer(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:30.0, vertical: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Скидка по программе лояльности. Активируется после первого заказа:',style: textRegular16,),
                                    const SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        const Icon(Icons.circle, size: 6,),
                                        const SizedBox(width: 8,),
                                        Text('3% на второй заказ,', style: textRegular16,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.circle, size: 6,),
                                        const SizedBox(width: 8,),
                                        Text(
                                          '7% на третий заказ',
                                          style: textRegular16,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    Text('Сохраняется, если заказывать каждую неделю. Действует до 23:59 среды.', style: textRegular16,),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              color: secondaryFullColor
                                          ),
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Закрыть',
                                            style: TextStyle(
                                              color: activeFullColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: SizedBox(
                    height: 22,
                    width: 22,
                    child: Stack(
                      children: [
                        SvgPicture.asset(icCircle),
                        Center(
                          child: SvgPicture.asset(icQuestion),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '-${discount.toString()}%',
              style: textRegular16,
            ),
          ],
        ),
        const SizedBox(height: 16,),
        CartDiscountInfo(
          discount: discount,
          // minCount: minCount,
          // maxCount: maxCount,
          // currentCount: currentCount,
        ),
      ],
    );
  }
}



class CartDiscountInfo extends StatefulWidget {
  const CartDiscountInfo({ Key key,
    @required this.discount,
    // @required this.minCount,
    // @required this.maxCount,
    // @required this.currentCount,
  }) : super(key: key);
  final int discount;
  // final int minCount;
  // final int maxCount;
  // final int currentCount;

  @override
  _CartDiscountInfoState createState() => _CartDiscountInfoState();
}

class _CartDiscountInfoState extends State<CartDiscountInfo>
    with TickerProviderStateMixin {
  Color get activeColor => /*isFull ? */activeDiscountFullColor /*: secondaryDiscountFullColor*/;

  Color get secondaryColor =>
     /* isFull ? */secondaryDiscountFullColor/* : secondaryDiscountFullColor*/;

  // bool get isFull => widget.currentCount >= widget.minCount;



  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: 8,
        child: Row(
          children: List.generate(
            // /*isFull ?*/ widget.maxCount/* : widget.minCount*/ /* 2 - 1*/,
            3,
                (index) {
              if (index.isOdd) {
                return const SizedBox(
              width: 8,
                  // width: ((index + 1) ~/ 2 + 1) <= widget.minCount || isFull
                  //     ? 8
                  //     : 0,
                );
              }
              return Expanded(
                child: _Dash(
                  color: (index ~/ 2 + 3) <= widget.discount
                      ? activeColor
                      : secondaryColor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Dash extends StatelessWidget {
  const _Dash({
    Key key,
    @required this.color,
  })  : assert(color != null),
        super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 8,
      color: color,
      duration: const Duration(milliseconds: 200),
    );
  }
}
