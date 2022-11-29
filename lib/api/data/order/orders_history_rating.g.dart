// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_history_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersHistoryRatingData _$OrdersHistoryRatingDataFromJson(
    Map<String, dynamic> json) {
  return OrdersHistoryRatingData(
    comment: json['comment'] as String,
    id: json['id'] as String,
    itemRating: json['item_rating'] as int,
    recipeRating: json['recipe_rating'] as int,
    reason: _$enumDecodeNullable(_$RatingReasonDataEnumMap, json['reason']),
  );
}

Map<String, dynamic> _$OrdersHistoryRatingDataToJson(
        OrdersHistoryRatingData instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'id': instance.id,
      'item_rating': instance.itemRating,
      'recipe_rating': instance.recipeRating,
      'reason': _$RatingReasonDataEnumMap[instance.reason],
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

const _$RatingReasonDataEnumMap = {
  RatingReasonData.cooking: 'cooking',
  RatingReasonData.other: 'other',
  RatingReasonData.quality: 'quality',
  RatingReasonData.taste: 'taste',
};
