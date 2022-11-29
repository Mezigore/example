import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/cart/cart.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/cart/cart_screen.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_order_button/cart_create_order_button_wm.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_order_button/di/cart_create_order_button_component.dart';

import '../cart_no_paper/cart_no_paper.dart';

/// Кнопка оформить в [CartScreen]
class CartCreateOrderButton extends MwwmWidget<CartCreateOrderButtonComponent> {
  CartCreateOrderButton({Key key})
      : super(
          widgetModelBuilder: createCartCreateOrderButtonWidgetModel,
          dependenciesBuilder: (context) =>
              CartCreateOrderButtonComponent(context),
          widgetStateBuilder: () => _CartCreateOrderButtonState(),
          key: key,
        );
}

class _CartCreateOrderButtonState
    extends WidgetState<CartCreateOrderButtonWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      top: false,
      child: EntityStateBuilder<Cart>(
        streamedState: wm.cartState,
        loadingChild: _LoadingButton(),
        errorBuilder: (_, cart, ___) => _ButtonWithHint(
          hint: cart.hintText,
          onTap: wm.createOrderAction,
          isLoading: wm.isLoadingData.stream,
          buttonTitle: cart.promoname.isNotEmpty
              ? cartCreateOrder
              : cart.canCreateOrder
                  ? cartCreateOrder
                  : cartOpenCatalog,
        ),
        child: (_, cart) => _ButtonWithHint(
          hint: cart.promoname != null ? '' : cart.hintText,
          onTap: () async {
            // await wm.createOrderAction();
            await wm.createOrder();
            if (wm.selectRecipeErr == true) {
              await showModalBottomSheet<bool>(
                  context: context,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  builder: (_) {
                    return _bottomSheetContainer(context: context);
              });
            }
          },
          isLoading: wm.isLoadingData.stream,
          buttonTitle: cart.promoname != null
              ? cartCreateOrder
              : cart.canCreateOrder
                  ? cartCreateOrder
                  : cartOpenCatalog,
        ),
      ),
    );
  }
}

class _ButtonWithHint extends StatelessWidget {
  const _ButtonWithHint({
    Key key,
    this.hint,
    this.buttonTitle,
    this.onTap,
    this.isLoading,
  }) : super(key: key);
  final String hint;
  final String buttonTitle;
  final VoidCallback onTap;
  final Stream<bool> isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 8,
            color: shadowColor.withOpacity(0.08),
          ),

          /// Для того чтобы убрать ненужную тень снизу
          BoxShadow(
              offset: Offset(0, hint != null ? 0 : 7), color: backgroundColor),
        ],
      ),
      child: Column(
        children: [
          if (hint != null) const SizedBox(height: 12),
          if (hint != null)
            Text(
              hint,
              style: textRegular12Secondary,
            ),
          StreamBuilder<bool>(
            stream: isLoading,
            builder: (context, snapshot) {
              return AcceptButton(
                text: buttonTitle,
                callback: onTap,
                isLoad: snapshot.data ?? false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LoadingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AcceptButton(
      isLoad: true,
    );
  }
}

Widget _bottomSheetContainer({BuildContext context}) {
  return BottomSheetContainer(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            cartRecipeTypeTitleErr,
            style: textMedium16,
          ),
          // const SizedBox(
          //   height: 16,
          // ),
          // Row(
          //   children: [
          //     const Icon(
          //       Icons.circle,
          //       size: 4,
          //       color: textColorHint,
          //     ),
          //     const SizedBox(
          //       width: 8,
          //     ),
          //     Text(
          //       cartPaperRecipe,
          //       style: textRegular14Hint,
          //     ),
          //   ],
          // ),
          // Row(
          //   children: [
          //     const Icon(
          //       Icons.circle,
          //       size: 4,
          //       color: textColorHint,
          //     ),
          //     const SizedBox(
          //       width: 8,
          //     ),
          //     Text(
          //       cartNoPaperRecipe,
          //       style: textRegular14Hint,
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 66,
          // ),
          const SizedBox(
            height: 16,
          ),
          CartNoPaper(
            bottomSheet: true,
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), color: secondaryFullColor),
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
  );
}
