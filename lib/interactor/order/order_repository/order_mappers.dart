import 'package:uzhindoma/api/data/order/bonus.dart';
import 'package:uzhindoma/api/data/order/bought_item.dart';
import 'package:uzhindoma/api/data/order/card_id.dart';
import 'package:uzhindoma/api/data/order/change_conditions.dart';
import 'package:uzhindoma/api/data/order/created_order.dart';
import 'package:uzhindoma/api/data/order/delivery_available.dart';
import 'package:uzhindoma/api/data/order/delivery_date.dart';
import 'package:uzhindoma/api/data/order/delivery_time_interval.dart';
import 'package:uzhindoma/api/data/order/extra_orders_history_item.dart';
import 'package:uzhindoma/api/data/order/new_order.dart';
import 'package:uzhindoma/api/data/order/order_from_history.dart';
import 'package:uzhindoma/api/data/order/order_id.dart';
import 'package:uzhindoma/api/data/order/order_status.dart';
import 'package:uzhindoma/api/data/order/order_summ.dart';
import 'package:uzhindoma/api/data/order/order_updating.dart';
import 'package:uzhindoma/api/data/order/orders_history_item.dart';
import 'package:uzhindoma/api/data/order/orders_history_rating.dart';
import 'package:uzhindoma/api/data/order/pay_system.dart';
import 'package:uzhindoma/api/data/order/payment_system.dart';
import 'package:uzhindoma/api/data/order/payment_type.dart';
import 'package:uzhindoma/api/data/order/promocode.dart';
import 'package:uzhindoma/api/data/order/raiting_reason.dart';
import 'package:uzhindoma/api/data/order/time_interval.dart';
import 'package:uzhindoma/domain/order/bonus.dart';
import 'package:uzhindoma/domain/order/bought_item.dart';
import 'package:uzhindoma/domain/order/card_id.dart';
import 'package:uzhindoma/domain/order/change_conditions.dart';
import 'package:uzhindoma/domain/order/created_order.dart';
import 'package:uzhindoma/domain/order/delivery_available.dart';
import 'package:uzhindoma/domain/order/delivery_date.dart';
import 'package:uzhindoma/domain/order/delivery_time_interval.dart';
import 'package:uzhindoma/domain/order/extra_orders_history_item.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/domain/order/order_from_history.dart';
import 'package:uzhindoma/domain/order/order_id.dart';
import 'package:uzhindoma/domain/order/order_status.dart';
import 'package:uzhindoma/domain/order/order_summ.dart';
import 'package:uzhindoma/domain/order/order_updating.dart';
import 'package:uzhindoma/domain/order/orders_history_item.dart';
import 'package:uzhindoma/domain/order/orders_history_raiting.dart';
import 'package:uzhindoma/domain/order/pay_system.dart';
import 'package:uzhindoma/domain/order/payment_type.dart';
import 'package:uzhindoma/domain/order/promocode.dart';
import 'package:uzhindoma/domain/order/rating_reason.dart';
import 'package:uzhindoma/domain/order/time_interval.dart';
import 'package:uzhindoma/interactor/address/repository/address_data_mappers.dart';
import 'package:uzhindoma/interactor/cart/repository/cart_data_mappers.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';

PaySystemData mapPaySystemData(PaySystem domain) {
  return PaySystemData(
    paymentToken: domain.paymentToken,
    paySystem: domain.paySystem.json,
  );
}

CreatedOrderData mapCreateOrderData(CreatedOrder domain) {
  return CreatedOrderData(
    addressId: domain.addressId,
    bonusAmount: domain.bonusAmount,
    cardId: domain.cardId,
    date: domain.date,
    name: domain.name,
    paymentType: domain.paymentType,
    phone: domain.phone,
    promoCode: domain.promoCode,
    time: domain.time,
    addressComment: domain.addressComment,
    isNoPaperRecipe: !domain.isNoPaperRecipe,
    isPromo: domain.isPromo,
  );
}

Bonus mapBonus(BonusData data) {
  return Bonus(bonusAmount: data.bonusAmount);
}

CardId mapCardId(CardIdData data) {
  return CardId(cardId: data.cardId);
}

CreatedOrder mapCreatedOrder(CreatedOrderData data) {
  return CreatedOrder(
    addressId: data.addressId,
    bonusAmount: data.bonusAmount,
    cardId: data.cardId,
    date: data.date,
    name: data.name,
    paymentType: data.paymentType,
    phone: data.phone,
    promoCode: data.promoCode,
    time: data.time,
    addressComment: data.addressComment,
    isNoPaperRecipe: !data.isNoPaperRecipe,
  );
}

DeliveryAvailable mapDeliveryAvailable(DeliveryAvailableData data) {
  return DeliveryAvailable(isAvailable: data.isAvailable);
}

DeliveryDate mapDeliveryDate(DeliveryDateData data) {
  return DeliveryDate(
    date: data.date,
    time: data.time.map(mapDeliveryTimeInterval).toList(),
  );
}

DeliveryTimeInterval mapDeliveryTimeInterval(DeliveryTimeIntervalData data) {
  return DeliveryTimeInterval(
    id: data.id,
    intervals: mapTimeInterval(data.intervals),
  );
}

OrderSum mapOrderSum(OrderSummData data) {
  return OrderSum(
    bonuses: data.bonuses,
    discount: data.discount,
    discountPrice: data.discountPrice,
    discountSum: data.discountSumm,
    discountCountSumm: data.discountCountSumm,
    sumId: data.summId,
    price: data.price,
    totalPrice: data.totalPrice,
    promoCode: data.promocode,
  );
}

PromoCode mapPromoCode(PromoCodeData data) {
  return PromoCode(promoCode: data.promoCode);
}

OrderId mapOrderId(OrderIdData data) {
  return OrderId(id: data.id.toString());
}

RatingReasonData mapRatingReasonData(RatingReason domain) {
  switch (domain) {
    case RatingReason.cooking:
      return RatingReasonData.cooking;
    case RatingReason.other:
      return RatingReasonData.other;
    case RatingReason.quality:
      return RatingReasonData.quality;
    case RatingReason.taste:
      return RatingReasonData.taste;
    default:
      throw EnumArgumentException('Not found RatingReason for $domain');
  }
}

TimeInterval mapTimeInterval(TimeIntervalData data) {
  return TimeInterval(
    from: data.from,
    to: data.to,
  );
}

OrderFromHistory mapOrderFromHistory(OrderFromHistoryData data) {
  return OrderFromHistory(
    id: data.id,
    orderDate: DateTime.parse(data.orderDate),
    canBeRated: data.canBeRated ?? false,
    extraItemsFromHistory:
        data.extraItemsFromHistory?.map(mapExtraOrdersHistoryItem)?.toList(),
    itemsFromHistory:
        data.itemsFromHistory?.map(mapOrdersHistoryItem)?.toList(),
  );
}

ExtraOrdersHistoryItem mapExtraOrdersHistoryItem(
    ExtraOrdersHistoryItemData data) {
  return ExtraOrdersHistoryItem(
    id: data.id,
    name: data.name,
    comment: data.comment,
    img: data.img,
    itemRating: data.itemRating,
  );
}

OrdersHistoryItem mapOrdersHistoryItem(OrdersHistoryItemData data) {
  return OrdersHistoryItem(
    comment: data.comment,
    id: data.id,
    img: data.img,
    itemRating: data.itemRating,
    name: data.name,
    recipeRating: data.recipeRating,
  );
}

NewOrder mapNewOrder(NewOrderData data) {
  return NewOrder(
    id: data.id,
    boughtExtraItems: data.boughtExtraItems?.map(mapExtraItem)?.toList(),
    boughtItems: data.boughtItems?.map(mapBoughtItem)?.toList(),
    canBeRestored: data.canBeRestored,
    changeConditions: mapChangeConditions(data.changeConditions),
    deliveryAddress: mapUserAddress(data.deliveryAddress),
    deliveryDate: DateTime.tryParse(data.deliveryDate),
    deliveryTime: mapTimeInterval(data.deliveryTime),
    name: data.name,
    orderDate: DateTime.parse(data.orderDate),
    orderSumm: mapOrderSum(data.orderSumm),
    paymentType: mapPaymentType(data.paymentType),
    phone: data.phone,
    status: mapOrderStatus(data.status),
    weekId: data.weekId,
    noPaperRecipe: data.noPaperRecipe,
  );
}

BoughtItem mapBoughtItem(BoughtItemData data) {
  return BoughtItem(
    id: data.id,
    discountPrice: data.discountPrice,
    name: data.name,
    previewImg: data.previewImg,
    price: data.price,
  );
}

ChangeConditions mapChangeConditions(ChangeConditionsData data) {
  return ChangeConditions(
    canChangeAddress: data?.canChangeAddress ?? false,
    canChangeDeliveryDate: data?.canChangeDeliveryDate ?? false,
    canChangePaymentType: data?.canChangePaymentType ?? false,
  );
}

PaymentType mapPaymentType(PaymentTypeData data) {
  switch (data) {
    case PaymentTypeData.card:
      return PaymentType.card;
    case PaymentTypeData.cash:
      return PaymentType.cash;
    // case PaymentTypeData.pay:
    //   return PaymentType.pay;
    default:
      throw EnumArgumentException('Not found PaymentType for $data');
  }
}

OrderStatus mapOrderStatus(OrderStatusData data) {
  switch (data) {
    case OrderStatusData.confirmed:
      return OrderStatus.confirmed;
    case OrderStatusData.paid:
      return OrderStatus.paid;
    case OrderStatusData.canceled:
      return OrderStatus.canceled;
    default:
      throw EnumArgumentException('Not found OrderStatus for $data');
  }
}

OrdersHistoryRatingData mapOrdersHistoryRatingData(OrdersHistoryRating data) {
  return OrdersHistoryRatingData(
    comment: data.comment,
    id: data.id,
    itemRating: data.itemRating,
    recipeRating: data.recipeRating,
    reason: data.reason == null || data.itemRating > 3
        ? null
        : mapRatingReasonData(data.reason),
  );
}

OrderUpdatingData mapOrderUpdatingData(OrderUpdating data) {
  return OrderUpdatingData(
    addressComment: data.addressComment,
    addressId: data.addressId,
    cardId: data.cardId,
    date: data.date,
    paymentType:
        data.paymentType == null ? null : mapPaymentTypeData(data.paymentType),
    time: data.time,
  );
}

PaymentTypeData mapPaymentTypeData(PaymentType data) {
  switch (data) {
    case PaymentType.card:
      return PaymentTypeData.card;
    case PaymentType.cash:
      return PaymentTypeData.cash;
    // case PaymentType.pay:
    //   return PaymentTypeData.pay;
    default:
      throw EnumArgumentException('Not found PaymentTypeData for $data');
  }
}
