import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

class DiscountSizeWidget extends StatelessWidget {
  const DiscountSizeWidget({
    Key key,
    @required this.minCount,
    @required this.maxCount,
    @required this.currentCount,
  }) : super(key: key);
  final int minCount;
  final int maxCount;
  final int currentCount;


  String get discount{
    if(currentCount==4){
      return '-10%';
    }else if(currentCount>4){
      return '-17%';
    }
      return '-0%';
  }

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
                  'За количество ужинов',
                  style: textRegular16,
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet<bool>(
                        context: context,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        builder: (_) => BottomSheetContainer(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:30, vertical: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Скидка за количество ужинов:',
                                      style: textRegular16,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 6,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '10% за 4 ужина',
                                          style: textRegular16,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 6,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '17% за 5 ужинов и более',
                                          style: textRegular16,
                                        ),
                                      ],
                                    ),
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
              discount,
              style: textRegular16,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        CartSizeInfoWidget(
          minCount: minCount,
          maxCount: maxCount,
          currentCount: currentCount,
        ),
      ],
    );
  }
}

/// Виджет с прогрессом заполнения корзины
class CartSizeInfoWidget extends StatefulWidget {
  const CartSizeInfoWidget({
    Key key,
    @required this.minCount,
    @required this.maxCount,
    @required this.currentCount,
  }) : super(key: key);
  final int minCount;
  final int maxCount;
  final int currentCount;

  @override
  _CartSizeInfoWidgetState createState() => _CartSizeInfoWidgetState();
}

class _CartSizeInfoWidgetState extends State<CartSizeInfoWidget> with TickerProviderStateMixin {
  Color get activeColor => activeFullColor;

  Color get secondaryColor => secondaryFullColor;

  bool get isFull => widget.currentCount >= widget.minCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        children: List.generate(
          // (isFull ? widget.maxCount : widget.minCount) * 2 - 1,
          3,
          (index) {
            if (index.isOdd) {
              return const SizedBox(
                width: 8,
              );
            }
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width-56)/2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: _Dash(
                        color: (index ~/ 2 + 4) <= widget.currentCount ? activeColor : secondaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Text('4 ужина',
                  style: textRegular12Gray,
                  ),
                ],
              );
            }
            if (index == 2) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width-48)/2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      child: _Dash(
                        color: (index ~/ 2 + 4) <= widget.currentCount ? activeColor : secondaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Text('5 ужинов',
                    style: textRegular12Gray,
                  ),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width-56)/3,
                  child: _Dash(
                      color: (index ~/ 2 + 4) <= widget.currentCount ? activeColor : secondaryColor,
                    ),
                ),
                const SizedBox(height: 8,),
                Text('4 ужина',
                  style: textRegular12Gray,
                ),
              ],
            );
          },
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
