import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/common/widgets/imported/round_checkbox.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_no_paper/cart_no_paper_wm.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_no_paper/di/cart_no_paper_component.dart';

/// Блок с отказом от печатных рецептов в CartScreen
class CartNoPaper extends MwwmWidget<CartNoPaperComponent> {
  CartNoPaper({Key key, this.bottomSheet = false})
      : super(
          widgetModelBuilder: (context) => createCartNoPaperWidgetModel(context, bottomSheet),
          dependenciesBuilder: (context) => CartNoPaperComponent(context),
          widgetStateBuilder: () => _CartNoPaperState(),
          key: key,
        );
  final bool bottomSheet;
}

class _CartNoPaperState extends WidgetState<CartNoPaperWidgetModel> {
  //false = paper na back
  bool checkbox = false;
  bool checkbox2 = false;

  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<List<bool>>(
      streamedState: wm.noPaperRecipeState,
      builder: (_, isNeedPaper) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: !wm.bottomSheet? 20.0: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(!wm.bottomSheet)...[
                Text(
                  cartRecipeTypeHeader,
                  style: textMedium24,
                ),
                const SizedBox(height: 8),
                Text(
                  cartRecipeTypeDescription,
                  style: textRegular12Gray,
                ),
                const SizedBox(height: 10),
              ],
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: isNeedPaper[1]
                              ? Colors.black54
                              : codeBorderColor,
                    ),
                    child: CircleCheckbox(
                      materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                      value: isNeedPaper[0] == null? false : !isNeedPaper[0],
                      onChanged: (_) {
                        checkbox = true;
                        checkbox2 = false;
                        wm.noPaperAction(checkbox2);
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              cartNoPaperRecipe,
                              style: textRegular16,
                            ),
                            const SizedBox(width: 10,),
                            GestureDetector(
                              onTap: () async {
                                await showModalBottomSheet<bool>(
                                    context: context,
                                    useRootNavigator: true,
                                    isScrollControlled: true,
                                    builder: (_) => const BottomSheetContainer(
                                      child: ResipeAbout(),
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
                        const SizedBox(height: 8),
                        Text(
                          cartNoPaperRecipeDescription,
                          style: textRegular12Gray,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: isNeedPaper[1]
                              ? Colors.black54
                              : codeBorderColor,
                    ),
                    child: CircleCheckbox(
                        materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                        value: isNeedPaper[0]?? false,
                        onChanged: (_) {
                          checkbox2 = true;
                          checkbox = false;
                          wm.noPaperAction(checkbox2);
                        }),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          cartPaperRecipe,
                          style: textRegular16,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cartPaperRecipeDescription,
                          style: textRegular12Gray,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}


class ResipeAbout extends StatelessWidget{
  const ResipeAbout({Key key,}) : super (key: key);


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:30.0, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            cartNoPaperAbout1,
            style: textRegular14Hint,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20,),
          Text(
            cartNoPaperAbout2,
            style: textRegular14Hint,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
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
    );
  }
}