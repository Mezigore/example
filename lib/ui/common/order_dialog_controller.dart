import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/domain/order/order_change_enum.dart';
import 'package:uzhindoma/domain/order/payment_type.dart';
import 'package:uzhindoma/domain/order/rating_reason.dart';
import 'package:uzhindoma/domain/payment/payment_card.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/owners/dialog_owner.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/address_picker_sheet.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/card_picker_sheet.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/change_order_sheet.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/low_rate_reason_bottom_sheet.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/payment_method_bottom_sheet.dart';

/// Диалог контроллер со вспомогательными далогами для оформления заказа
class OrderDialogController extends DefaultDialogController {
  OrderDialogController(GlobalKey<ScaffoldState> scaffoldKey,
      {DialogOwner dialogOwner})
      : super(scaffoldKey, dialogOwner: dialogOwner);

  OrderDialogController.from(BuildContext context, {DialogOwner dialogOwner})
      : super.from(context, dialogOwner: dialogOwner);

  /// Вызов шторки выбора карты
  Future<PaymentCard> showPaymentCardPicker(
    List<PaymentCard> cards, {
    PaymentCard currentCard,
  }) {
    assert(cards != null);
    return showModalBottomSheet<PaymentCard>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => CardPickerSheet(
        cards: cards,
        currentCard: currentCard,
      ),
    );
  }

  /// Вызов шторки выбора адреса
  Future<UserAddress> showAddressPicker(
    List<UserAddress> addresses,
    UserAddress currentAddress,
  ) {
    assert(addresses != null);
    assert(currentAddress != null);
    return showModalBottomSheet<UserAddress>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => AddressPickerSheet(
        addresses: addresses,
        currentAddress: currentAddress,
      ),
    );
  }

  /// Вызов шторки выбора способа оплаты
  Future<PaymentType> showPaymentMethodPicker(
    List<PaymentType> methods,
  ) {
    assert(methods != null);
    return showModalBottomSheet<PaymentType>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => PaymentMethodSheet(methods: methods),
    );
  }

  /// Вызов шторки с выбором что менять в заказе
  Future<OrderChanges> showOrderChangesPicker(
    List<OrderChanges> changes,
  ) {
    assert(changes != null);
    assert(changes.isNotEmpty);
    return showModalBottomSheet<OrderChanges>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => ChangeOrderSheet(changes: changes),
    );
  }

  /// Вызов шторки с выбором что не понравилось в заказе
  Future<RatingReason> showOrderLowRateReasonPicker(
    List<RatingReason> reasons,
  ) {
    assert(reasons != null);
    assert(reasons.isNotEmpty);
    return showModalBottomSheet<RatingReason>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => LowRateSheet(reasons: reasons),
    );
  }
}
