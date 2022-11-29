import 'package:json_annotation/json_annotation.dart';

part 'recipe_description.g.dart';

/// Пошаговый рецепт
@JsonSerializable()
class RecipeDescriptionData {
  RecipeDescriptionData({
    this.descr,
    this.step,
  });

  factory RecipeDescriptionData.fromJson(Map<String, dynamic> json) =>
      _$RecipeDescriptionDataFromJson(json);

  /// Описание шага рецепта
  final String descr;

  /// Шаг рецепта
  final int step;

  Map<String, dynamic> toJson() => _$RecipeDescriptionDataToJson(this);
}
