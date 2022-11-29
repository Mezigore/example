import 'package:uzhindoma/api/data/recipes/arhive.dart';
import 'package:uzhindoma/api/data/recipes/recipe.dart';
import 'package:uzhindoma/api/data/recipes/recipe_description.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/domain/recipes/recipe_description.dart';

// ignore: avoid_positional_boolean_parameters
ArhiveData mapArhiveData(bool toArchive) {
  return ArhiveData(toArchive: toArchive);
}

Recipe mapRecipe(RecipeData data) {
  return Recipe(
    bguCal: data.bguCal,
    bguCarb: data.bguCarb,
    bguFat: data.bguFat,
    bguProtein: data.bguProtein,
    cookBefore:
        data.cookBefore == null ? null : DateTime.tryParse(data.cookBefore),
    cookTime: data.cookTime,
    detailImg: data.detailImg,
    id: data.id,
    name: data.name,
    previewImg: data.previewImg,
    ratio: data.ratio,
    weight: data.weight,
    willDeliver: data.willDeliver,
    youNeed: data.youNeed,
    rate: data.rate,
    orderId: data.orderId,
    productId: data.productId,
    recipes: data?.recipes?.map(mapRecipeDescription)?.toList(),
    isFavorite: data.isFavorite,
    showTime: DateTime.fromMillisecondsSinceEpoch(data.showTime*1000),
    hideTime: DateTime.fromMillisecondsSinceEpoch(data.hideTime*1000),
    toShow: data.toShow,
  );
}

RecipeDescription mapRecipeDescription(RecipeDescriptionData data) {
  return RecipeDescription(
    descr: data.descr,
    step: data.step,
  );
}
