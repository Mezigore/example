import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/order/order_summ.dart';
import 'package:uzhindoma/domain/order/payment_type.dart';
import 'package:uzhindoma/domain/payment/payment_card.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/ui/common/text_field_border.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/common/widgets/imported/round_checkbox.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_price_loader.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/di/select_payment_screen_component.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/select_payment_screen_wm.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/widgets/bonus_widget.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/widgets/order_tap_field.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/widgets/select_card_widget.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/widgets/sum_widget.dart';
import 'package:uzhindoma/ui/widget/common/loading_widget.dart';
import 'package:uzhindoma/util/const.dart';

enum PromoCodeState {
  loading,
  applied,
  canBeApplied,
  cannotBeApplied,
  error,
}

/// Экран для выбора способа оплаты
class SelectPaymentScreen extends MwwmWidget<SelectPaymentScreenComponent> {
  SelectPaymentScreen({Key key})
      : super(
          widgetModelBuilder: createSelectPaymentScreenWidgetModel,
          dependenciesBuilder: (context) =>
              SelectPaymentScreenComponent(context),
          widgetStateBuilder: () => _SelectPaymentScreenState(),
          key: key,
        );
}

class _SelectPaymentScreenState
    extends WidgetState<SelectPaymentScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<SelectPaymentScreenComponent>(context)
          .component
          .scaffoldKey,
      appBar: DefaultAppBar(
        title: createOrderTitle,
        leadingIcon: Icons.arrow_back_ios,
        onLeadingTap: wm.back,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
              SliverToBoxAdapter(
                child: Text(createOrderPaymentTitle, style: textMedium24),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: StreamedStateBuilder<PaymentType>(
                  streamedState: wm.paymentMethodState,
                  builder: (_, method) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrderTapField(
                          text: method.title,
                          onTap: wm.selectPaymentMethodAction,
                        ),
                        if (method == PaymentType.card)
                          StreamedStateBuilder<PaymentCard>(
                            streamedState: wm.paymentCardState,
                            builder: (_, card) {
                              return SelectCardBlock(
                                currentCard: card,
                                cardsState: wm.cardsState,
                                onCardTap: wm.selectPaymentCardAction,
                                onAddCard: wm.addPaymentCardAction,
                              );
                            },
                          ),
                      ],
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              if(!wm.isPromo)...[
                SliverToBoxAdapter(
                  child: StreamedStateBuilder<bool>(
                    streamedState: wm.isEnableBonusState,
                    builder: (_, isEnabled) {
                      return EntityStateBuilder<int>(
                        streamedState: wm.bonusesState,
                        loadingChild: const AbsorbPointer(
                          child: _BonusesBlock(isLoading: true),
                        ),
                        errorChild: const AbsorbPointer(
                          child: _BonusesBlock(hasError: true),
                        ),
                        child: (_, bonus) {
                          return _BonusesBlock(
                            bonus: bonus,
                            isSelected: isEnabled,
                            onChangeSelected:
                                bonus == 0 ? null : wm.changeBonusEnabledAction,
                          );
                        },
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamedStateBuilder<bool>(
                    streamedState: wm.isEnablePromoCodeState,
                    builder: (_, isEnabled) {
                      return StreamedStateBuilder<PromoCodeState>(
                        streamedState: wm.promoCodeState,
                        builder: (_, state) => _PromoCodeBlock(
                          state: state,
                          isEnablePromoCode: isEnabled,
                          onApplyPromoCode: wm.applyPromoCodeAction,
                          promoCodeController: wm.promoCodeController,
                          promoCodeFocus: wm.promoCodeFocusNode,
                          changeEnableState: wm.changePromoCodeEnabledAction,
                        ),
                      );
                    },
                  ),
                ),
              ],

              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: EntityStateBuilder<OrderSum>(
                    streamedState: wm.sumState,
                    loadingChild: _BottomLoader(),
                    errorBuilder: (_, sum, e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 40),
                        const Divider(color: dividerLightColor),
                        const SizedBox(height: 24),
                        StreamedStateBuilder<int>(
                          streamedState: wm.countDishes,
                          builder: (_, count) {
                            return SumWidget(
                              sum: sum,
                              count: count,
                            );
                          },
                        ),
                        const SizedBox(height: 52),
                        StreamedStateBuilder<bool>(
                          streamedState: wm.isCreatingOrder,
                          builder: (_, isCreating) {
                            return StreamedStateBuilder<PaymentType>(
                                streamedState: wm.paymentMethodState,
                                builder: (context, type) {
                                  return _CreateOrderBtn(
                                    isLoading: isCreating,
                                    isPaySystem: type == PaymentType.card,
                                    onTap: wm.nextAction,
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                    child: (_, sum) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 40),
                        const Divider(color: dividerLightColor),
                        const SizedBox(height: 24),
                        StreamedStateBuilder<int>(
                          streamedState: wm.countDishes,
                          builder: (_, count) {
                            return SumWidget(
                              sum: sum,
                              count: count,
                            );
                          },
                        ),
                        const SizedBox(height: 52),
                        StreamedStateBuilder<bool>(
                          streamedState: wm.isCreatingOrder,
                          builder: (_, isCreating) {
                            return StreamedStateBuilder<PaymentType>(
                              streamedState: wm.paymentMethodState,
                              builder: (context, type) {
                                return _CreateOrderBtn(
                                  isLoading: isCreating,
                                  isPaySystem: type == PaymentType.card,
                                  onTap: wm.nextAction,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateOrderBtn extends StatelessWidget {
  const _CreateOrderBtn({
    Key key,
    this.isLoading,
    this.isPaySystem,
    this.onTap,
  }) : super(key: key);

  final bool isLoading;
  final bool isPaySystem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // if (isPaySystem) {
    //   return _PaySystemButton(
    //     onTap: onTap,
    //     isLoad: isLoading ?? false,
    //   );
    // } else {
      return AcceptButton(
        isLoad: isLoading ?? false,
        text: createOrderBtnCreateTitle,
        callback: onTap,
        padding: EdgeInsets.zero,
      );
    // }
  }
}

// class _PaySystemButton extends StatelessWidget {
//   const _PaySystemButton({
//     Key key,
//     this.onTap,
//     this.isLoad,
//   }) : super(key: key);
//   final VoidCallback onTap;
//   final bool isLoad;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 76,
//       color: white,
//       width: double.infinity,
//       padding: EdgeInsets.zero,
//       child: Center(
//         child: SizedBox(
//           width: double.infinity,
//           height: 48,
//           child: ElevatedButton(
//             onPressed: isLoad ? null : onTap,
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(Colors.black),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//               ),
//             ),
//             child: isLoad
//                 ? const LoadingWidget()
//                 : SizedBox(
//                     height: 22,
//                     child: SvgPicture.asset(
//                       Platform.isIOS ? icApplePay : icGooglePay,
//                     ),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CartSumLoader(),
        SizedBox(height: 52),
        AcceptButton(
          isLoad: true,
          text: createOrderBtnNextTitle,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

class _BonusesBlock extends StatelessWidget {
  const _BonusesBlock({
    Key key,
    bool isSelected,
    this.onChangeSelected,
    this.isLoading,
    this.hasError,
    this.bonus,
  })  : isSelected = isSelected ?? false,
        super(key: key);

  final bool isSelected;
  final ValueChanged<bool> onChangeSelected;
  final bool isLoading;
  final bool hasError;
  final int bonus;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: onChangeSelected == null
            ? null
            : () => onChangeSelected(!isSelected),
        borderRadius: BorderRadius.circular(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleCheckbox(
              value: isSelected,
              onChanged: onChangeSelected,
            ),
            const SizedBox(width: 10),
            Text(createOrderApplyBonus, style: textRegular16),
            const SizedBox(width: 12),
            BonusWidget(
              hasError: hasError,
              isLoading: isLoading,
              bonuses: bonus,
            )
          ],
        ),
      ),
    );
  }
}

class _PromoCodeBlock extends StatelessWidget {
  const _PromoCodeBlock({
    Key key,
    this.changeEnableState,
    this.isEnablePromoCode,
    this.promoCodeController,
    this.onApplyPromoCode,
    @required this.state,
    this.promoCodeFocus,
  })  : assert(state != null),
        super(key: key);

  final VoidCallback onApplyPromoCode;
  final bool isEnablePromoCode;
  final PromoCodeState state;
  final ValueChanged<bool> changeEnableState;
  final TextEditingController promoCodeController;
  final FocusNode promoCodeFocus;

  @override
  Widget build(BuildContext context) {
    Widget suffix;
    switch (state) {
      case PromoCodeState.loading:
        suffix = const LoadingWidget(color: iconColor);
        break;
      case PromoCodeState.cannotBeApplied:
        suffix = const _EnterPromoCodeBtn();
        break;
      case PromoCodeState.error:
      case PromoCodeState.canBeApplied:
        suffix = _EnterPromoCodeBtn(onTap: onApplyPromoCode);
        break;
      case PromoCodeState.applied:
        suffix = Icon(
          Icons.check,
          color: Theme.of(context).accentColor,
          size: 24,
        );
        break;
      default:
        throw EnumArgumentException('Not found PromoCodeState for $this');
    }

    final isError = state == PromoCodeState.error;

    return AbsorbPointer(
      absorbing: state == PromoCodeState.loading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => changeEnableState(!isEnablePromoCode),
            borderRadius: BorderRadius.circular(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleCheckbox(
                  value: isEnablePromoCode,
                  onChanged: changeEnableState,
                ),
                const SizedBox(width: 10),
                Text(createOrderApplyPromoCode, style: textRegular16),
              ],
            ),
          ),
          if (isEnablePromoCode)
            AbsorbPointer(
              absorbing: state == PromoCodeState.applied,
              child: Stack(
                children: [
                  SizedBox(
                    height: 56,
                    child: TextFormField(
                      controller: promoCodeController,
                      enableSuggestions: false,
                      focusNode: promoCodeFocus,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: onApplyPromoCode,
                      decoration: InputDecoration(
                        labelText: createOrderPromoCode,
                        border: isError
                            ? const NoJumpOutLineBorder(
                                borderSide: BorderSide(
                                  color: codeBorderColor,
                                  width: 2,
                                ),
                              )
                            : null,
                        errorText: isError ? emptyString : null,
                        errorStyle: const TextStyle(height: 0),
                        contentPadding: const EdgeInsets.fromLTRB(12, 8, 60, 8),
                      ),
                    ),
                  ),
                  Container(
                    height: 56,
                    padding: const EdgeInsets.only(right: 16),
                    alignment: Alignment.centerRight,
                    child: suffix,
                  ),
                ],
              ),
            ),
          if (isError) Text(wrongPromoCode, style: textRegular12Error),
          if (isError) const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _EnterPromoCodeBtn extends StatelessWidget {
  const _EnterPromoCodeBtn({
    Key key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          color: onTap == null ? iconColor : Theme.of(context).accentColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_forward_rounded, color: white),
      ),
    );
  }
}
