// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeDescriptionData _$RecipeDescriptionDataFromJson(
    Map<String, dynamic> json) {
  return RecipeDescriptionData(
    descr: json['descr'] as String,
    step: json['step'] as int,
  );
}

Map<String, dynamic> _$RecipeDescriptionDataToJson(
        RecipeDescriptionData instance) =>
    <String, dynamic>{
      'descr': instance.descr,
      'step': instance.step,
    };
