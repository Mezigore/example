import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/domain/order/delivery_date.dart';
import 'package:uzhindoma/domain/order/delivery_time_interval.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/domain/order/order_change_enum.dart';
import 'package:uzhindoma/domain/order/payment_type.dart';
import 'package:uzhindoma/domain/payment/payment_card.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/common/widgets/imported/round_checkbox.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_address/widgets/address_fields.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_delivery_date/widgets/delivery_date_list.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_delivery_date/widgets/time_interval_list.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/widgets/bonus_widget.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/widgets/order_tap_field.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/widgets/select_card_widget.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/widgets/sum_widget.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/change_order/change_order_screen_wm.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/change_order/di/change_order_screen_component.dart';
import 'package:uzhindoma/ui/widget/error/error.dart';

/// Экран изменения заказа
class ChangeOrderScreen extends MwwmWidget<ChangeOrderScreenComponent> {
  ChangeOrderScreen({
    Key key,
    OrderChanges change,
    NewOrder order,
  }) : super(
          key: key,
          widgetStateBuilder: () => _ChangeOrderScreenState(),
          dependenciesBuilder: (context) => ChangeOrderScreenComponent(context),
          widgetModelBuilder: (context) => createChangeOrderScreenWidgetModel(
            context,
            change,
            order,
          ),
        );
}

class _ChangeOrderScreenState
    extends WidgetState<ChangeOrderScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (wm.change) {
      case OrderChanges.changePaymentType:
        child = _ChangePaymentType(
          order: wm.order,
          paymentMethodState: wm.paymentMethodState,
          paymentCardState: wm.paymentCardState,
          cardsState: wm.cardsState,
          onTypeTap: wm.selectPaymentMethodAction,
          onSelectCard: wm.selectPaymentCardAction,
          onAddCard: wm.addPaymentCardAction,
        );
        break;
      case OrderChanges.changeDeliveryDate:
        child = _ChangeDate(
          dateState: wm.dateState,
          selectedDeliveryDateState: wm.selectedDeliveryDateState,
          intervalsState: wm.selectedIntervalState,
          onSelectDate: wm.selectDateAction,
          onIntervalSelected: wm.selectIntervalAction,
          onReload: wm.reloadDatesAction,
        );
        break;
      case OrderChanges.changeAddress:
        child = StreamedStateBuilder<UserAddress>(
          streamedState: wm.addressState,
          builder: (_, address) => _ChangeAddress(
            address: address,
            order: wm.order,
            onAddressTap: wm.addressTapAction,
            onAddAddressTap: wm.addAddressAction,
            commentTextController: wm.commentTextController,
          ),
        );
        break;
      default:
        throw EnumArgumentException(
            'Not found PaymentTypeData for ${wm.change}');
    }

    return Scaffold(
      key: Injector.of<ChangeOrderScreenComponent>(context)
          .component
          .scaffoldKey,
      appBar: const DefaultAppBar(
        title: changeOrderTitle,
        leadingIcon: Icons.arrow_back_ios,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: child,
            ),
            _SaveButton(
              onTap: wm.saveAction,
              isLoadingState: wm.isLoadingState,
            ),
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    Key key,
    @required this.onTap,
    @required this.isLoadingState,
  })  : assert(onTap != null),
        assert(isLoadingState != null),
        super(key: key);
  final VoidCallback onTap;
  final StreamedState<bool> isLoadingState;

  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<bool>(
      streamedState: isLoadingState,
      builder: (_, isLoad) => AcceptButton(
        callback: onTap,
        text: userDetailsWidgetSaveText,
      ),
    );
  }
}

class _ChangeAddress extends StatelessWidget {
  const _ChangeAddress({
    Key key,
    @required this.address,
    @required this.onAddressTap,
    @required this.commentTextController,
    @required this.onAddAddressTap,
    @required this.order,
  })  : assert(address != null),
        assert(onAddressTap != null),
        assert(commentTextController != null),
        assert(onAddAddressTap != null),
        assert(order != null),
        super(key: key);
  final NewOrder order;
  final UserAddress address;
  final VoidCallback onAddressTap;
  final VoidCallback onAddAddressTap;
  final TextEditingController commentTextController;

  bool get forAnotherClient => order.name != null && order.name.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              createOrderAddressTitle,
              style: textMedium24,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AddressFields(
              address: address,
              onAddressPressed: onAddressTap,
              commentController: commentTextController,
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: TextButton(
              onPressed: onAddAddressTap,
              child: Text(
                addressAddNewAddressButton,
                style: textMedium16Accent,
              ),
            ),
          ),
          if (forAnotherClient)
            _AnotherClientBlock(
              name: order.name,
              phone: order.phone,
            ),
        ],
      ),
    );
  }
}

class _AnotherClientBlock extends StatelessWidget {
  const _AnotherClientBlock({
    Key key,
    this.name,
    this.phone,
  }) : super(key: key);

  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: AbsorbPointer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleCheckbox(value: true),
                  Text(
                    createOrderAnotherClient,
                    style: textRegular16,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(
                    labelText: userDetailsWidgetNameText,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  initialValue: phone,
                  decoration: const InputDecoration(
                    labelText: userDetailsWidgetPhoneText,
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

class _ChangePaymentType extends StatelessWidget {
  const _ChangePaymentType({
    Key key,
    @required this.order,
    @required this.paymentMethodState,
    @required this.paymentCardState,
    @required this.cardsState,
    @required this.onTypeTap,
    @required this.onAddCard,
    @required this.onSelectCard,
  }) : super(key: key);

  final NewOrder order;
  final StreamedState<PaymentType> paymentMethodState;
  final StreamedState<PaymentCard> paymentCardState;
  final EntityStreamedState<List<PaymentCard>> cardsState;
  final VoidCallback onTypeTap;
  final VoidCallback onAddCard;
  final VoidCallback onSelectCard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text(createOrderPaymentTitle, style: textMedium24),
                  const SizedBox(height: 24),
                  StreamedStateBuilder<PaymentType>(
                    streamedState: paymentMethodState,
                    builder: (_, method) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OrderTapField(
                            text: method.title,
                            onTap: onTypeTap,
                          ),
                          if (method == PaymentType.card)
                            StreamedStateBuilder<PaymentCard>(
                              streamedState: paymentCardState,
                              builder: (_, card) {
                                return SelectCardBlock(
                                  currentCard: card,
                                  cardsState: cardsState,
                                  onCardTap: onSelectCard,
                                  onAddCard: onAddCard,
                                );
                              },
                            ),
                        ],
                      );
                    },
                  ),
                  if (order.orderSumm.bonuses != null &&
                      order.orderSumm.bonuses != 0)
                    _BonusBlock(order: order),
                  if (order.orderSumm.promoCode != null &&
                      order.orderSumm.promoCode != 0)
                    _PromoCodeBlock(),
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: SumWidget(sum: order.orderSumm)),
        ],
      ),
    );
  }
}

class _PromoCodeBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleCheckbox(value: true),
          const SizedBox(width: 10),
          Text(createOrderApplyPromoCode, style: textRegular16),
        ],
      ),
    );
  }
}

class _BonusBlock extends StatelessWidget {
  const _BonusBlock({
    Key key,
    this.order,
  }) : super(key: key);

  final NewOrder order;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleCheckbox(value: true),
          const SizedBox(width: 10),
          Text(createOrderApplyBonus, style: textRegular16),
          const SizedBox(width: 12),
          BonusWidget(bonuses: order.orderSumm.bonuses),
        ],
      ),
    );
  }
}

class _ChangeDate extends StatelessWidget {
  const _ChangeDate({
    Key key,
    @required this.dateState,
    @required this.selectedDeliveryDateState,
    @required this.intervalsState,
    @required this.onReload,
    @required this.onSelectDate,
    @required this.onIntervalSelected,
  }) : super(key: key);

  final EntityStreamedState<List<DeliveryDate>> dateState;
  final StreamedState<DeliveryDate> selectedDeliveryDateState;
  final StreamedState<DeliveryTimeInterval> intervalsState;
  final VoidCallback onReload;
  final ValueChanged<DeliveryDate> onSelectDate;
  final ValueChanged<DeliveryTimeInterval> onIntervalSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: EntityStateBuilder<List<DeliveryDate>>(
        streamedState: dateState,
        loadingChild: _DateLoading(),
        errorChild: ErrorStateWidget(onReloadAction: onReload),
        child: (_, listOfDate) {
          return StreamedStateBuilder<DeliveryDate>(
            streamedState: selectedDeliveryDateState,
            builder: (_, selectedDate) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      createOrderDateTitle,
                      style: textMedium24,
                    ),
                    const SizedBox(height: 20),
                    DeliveryDateList(
                      listOfDates: listOfDate,
                      currentDate: selectedDate,
                      onDateTap: onSelectDate,
                    ),
                    if (selectedDate != null &&
                        selectedDate.time != null &&
                        selectedDate.time.isNotEmpty) ...[
                      const SizedBox(height: 48),
                      Text(
                        createOrderTimeIntervalTitle,
                        style: textMedium24,
                      ),
                      const SizedBox(height: 24),
                      StreamedStateBuilder<DeliveryTimeInterval>(
                        streamedState: intervalsState,
                        builder: (_, selectedInterval) {
                          return IntervalsList(
                            date: selectedDate,
                            currentInterval: selectedInterval,
                            onIntervalTap: onIntervalSelected,
                          );
                        },
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _DateLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Text(
            createOrderDateTitle,
            style: textMedium24,
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(
                child: SkeletonWidget(
                  isLoading: true,
                  height: 40,
                  radius: 8,
                  width: double.infinity,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: SkeletonWidget(
                  isLoading: true,
                  height: 40,
                  radius: 8,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
