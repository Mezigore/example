// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewOrderData _$NewOrderDataFromJson(Map<String, dynamic> json) {
  return NewOrderData(
    boughtExtraItems: (json['bought_extra_items'] as List)
        ?.map((e) => e == null ? null : ExtraItemData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    boughtItems: (json['bought_items'] as List)
        ?.map((e) => e == null ? null : BoughtItemData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    canBeRestored: json['can_be_restored'] as bool,
    changeConditions: json['change_conditions'] == null
        ? null
        : ChangeConditionsData.fromJson(json['change_conditions'] as Map<String, dynamic>),
    deliveryAddress: json['delivery_address'] == null
        ? null
        : UserAddressData.fromJson(json['delivery_address'] as Map<String, dynamic>),
    deliveryDate: json['delivery_date'] as String,
    deliveryTime:
        json['delivery_time'] == null ? null : TimeIntervalData.fromJson(json['delivery_time'] as Map<String, dynamic>),
    id: json['id'] as String,
    name: json['name'] as String,
    orderDate: json['order_date'] as String,
    orderSumm: json['order_summ'] == null ? null : OrderSummData.fromJson(json['order_summ'] as Map<String, dynamic>),
    weekId: json['week_id'] as String,
    paymentType: _$enumDecodeNullable(_$PaymentTypeDataEnumMap, json['payment_type']),
    phone: json['phone'] as String,
    status: _$enumDecodeNullable(_$OrderStatusDataEnumMap, json['status']),
    noPaperRecipe: json['no_paper_reciре'] as bool,
  );
}

Map<String, dynamic> _$NewOrderDataToJson(NewOrderData instance) =>
    <String, dynamic>{
      'bought_extra_items': instance.boughtExtraItems,
      'bought_items': instance.boughtItems,
      'can_be_restored': instance.canBeRestored,
      'change_conditions': instance.changeConditions,
      'delivery_address': instance.deliveryAddress,
      'delivery_date': instance.deliveryDate,
      'delivery_time': instance.deliveryTime,
      'week_id': instance.weekId,
      'id': instance.id,
      'name': instance.name,
      'order_date': instance.orderDate,
      'order_summ': instance.orderSumm,
      'payment_type': _$PaymentTypeDataEnumMap[instance.paymentType],
      'no_paper_reciре': instance.noPaperRecipe,
      'phone': instance.phone,
      'status': _$OrderStatusDataEnumMap[instance.status],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PaymentTypeDataEnumMap = {
  PaymentTypeData.card: 'card',
  PaymentTypeData.cash: 'cash',
};

const _$OrderStatusDataEnumMap = {
  OrderStatusData.canceled: 'Canceled',
  OrderStatusData.paid: 'Paid',
  OrderStatusData.confirmed: 'Confirmed',
};
