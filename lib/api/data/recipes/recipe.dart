import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/recipes/recipe_description.dart';

part 'recipe.g.dart';

/// Рецепт
@JsonSerializable()
class RecipeData {
  RecipeData({
    this.bguCal,
    this.bguCarb,
    this.bguFat,
    this.bguProtein,
    this.cookBefore,
    this.cookTime,
    this.detailImg,
    this.id,
    this.name,
    this.previewImg,
    this.ratio,
    this.recipes,
    this.weight,
    this.willDeliver,
    this.youNeed,
    this.rate,
    this.orderId,
    this.productId,
    this.isFavorite,
    this.showTime,
    this.hideTime,
    this.toShow,
  });

  factory RecipeData.fromJson(Map<String, dynamic> json) =>
      _$RecipeDataFromJson(json);

  /// Ккал
  @JsonKey(name: 'bgu_cal')
  final double bguCal;

  /// Углеводы
  @JsonKey(name: 'bgu_carb')
  final double bguCarb;

  /// Жиры
  @JsonKey(name: 'bgu_fat')
  final double bguFat;

  /// Белок
  @JsonKey(name: 'bgu_protein')
  final double bguProtein;

  /// Дата "Приготовить до" в формате ISO 8601 "yyyy-MM-dd".
  @JsonKey(name: 'cook_before')
  final String cookBefore;

  /// Время приготовления блюда в минутах
  @JsonKey(name: 'cook_time')
  final int cookTime;

  /// Ссылка на картинку для деталей
  @JsonKey(name: 'detail_img')
  final String detailImg;

  /// ID рецепта
  final String id;

  final String name;

  /// Ссылка на картинку для списка
  @JsonKey(name: 'preview_img')
  final String previewImg;

  /// Количество порций, по сколько элементов добавляется в корзину
  final String ratio;

  final List<RecipeDescriptionData> recipes;

  /// Вес блюда
  final int weight;

  /// Описание ингредиентов для приготовления
  @JsonKey(name: 'will_deliver')
  final String willDeliver;

  /// Описание необходимых инструментов для приготовления
  @JsonKey(name: 'you_need')
  final String youNeed;

  /// Рейтинг рецепта
  final int rate;

  /// Id заказа, в котором пришел данный рецепт
  @JsonKey(name: 'order_id')
  final String orderId;

 @JsonKey(name: 'product_id')
  final String productId;

 @JsonKey(name: 'is_favorite')
  final bool isFavorite;

  /// временная метка (timestamp), в какой момент начинается показ рецепта
  @JsonKey(name: 'show_time')
  final int showTime;

  /// временная метка (timestamp), в какой момент завершается показ рецепта
  @JsonKey(name: 'hide_time')
  final int hideTime;

  @JsonKey(name: 'to_show')
  final bool toShow;

  Map<String, dynamic> toJson() => _$RecipeDataToJson(this);
}
