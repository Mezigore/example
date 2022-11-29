import 'package:uzhindoma/domain/recipes/recipe_description.dart';
import 'package:uzhindoma/domain/time.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/util/const.dart';
import 'package:uzhindoma/util/date_formatter.dart';
import 'package:uzhindoma/util/time_formatter.dart';

/// Рецепт
class Recipe {
  Recipe({
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

  /// Ккал
  final double bguCal;

  /// Углеводы
  final double bguCarb;

  /// Жиры
  final double bguFat;

  /// Белок
  final double bguProtein;

  /// Дата "Приготовить до" в формате ISO 8601 "yyyy-MM-dd".
  final DateTime cookBefore;

  /// Время приготовления блюда в минутах
  final int cookTime;

  /// Ссылка на картинку для деталей
  final String detailImg;

  /// ID рецепта
  final String id;

  final String name;

  /// Ссылка на картинку для списка
  final String previewImg;

  /// Лайк на рецепте
  final bool isFavorite;

  /// временная метка (timestamp), в какой момент начинается показ рецепта
  final DateTime showTime;

  /// временная метка (timestamp), в какой момент завершается показ рецепта
  final DateTime hideTime;

  /// булевское значение, принимающее значение true, если текущее время находится между show_time и hide_time, иначе false
  final bool toShow;

  /// Количество порций, по сколько элементов добавляется в корзину
  final String ratio;

  final List<RecipeDescription> recipes;

  /// Вес блюда
  final int weight;

  /// Описание ингредиентов для приготовления
  final String willDeliver;

  /// Описание необходимых инструментов для приготовления
  final String youNeed;

  /// Рейтинг рецепта
  final int rate;

  /// Id заказа, в котором пришел данный рецепт
  final String orderId;

  final String productId;

  String _dateTitle;

  String get dateTitle {
    if (cookBefore == null) return emptyString;
    _dateTitle ??=
        '$recipesDatePrefix ${DateUtil.formatDayMonthDayWeek(cookBefore)}';
    return _dateTitle;
  }

  /// Переводим минуты в удобночитаемое время
  String get cookTimeUi => cookTime == null
      ? ellipsisText
      : TimeFormatter.formatToString(
          TimeDuration.fromMinutes(cookTime),
          isShort: true,
        );

  /// Колличество порций и вес
  String get portionUi {
    final intRation = int.tryParse(ratio);
    final res = intRation == null ? emptyString : '$intRation x';
    return weight == null || ratio == null
        ? ellipsisText
        : '$res ${weight ~/ intRation} $gramText';
  }
}
