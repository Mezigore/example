import 'package:uzhindoma/domain/catalog/menu/menu_label.dart';
import 'package:uzhindoma/domain/time.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/util/const.dart';
import 'package:uzhindoma/util/time_formatter.dart';

/// Свойства блюда.
/// [labels] - Массив лейблов [MenuItemLabel].
/// [mainLabel] - Праздничный лейбл [MenuItemMainLabel].
/// [cookTime] - Время приготовления блюда в минутах.
/// [weight] - Вес блюда.
/// [ratio] - Количество порций, по сколько элементов добавляется в корзину.
/// [willDeliver] - Количество порций, по сколько элементов добавляется в корзину.
/// [youNeed] - Описание необходимых инструментов для приготовления.
/// [prepareComment] - Рекомендации по сроку приготовления.
/// [bguCal] - Ккал.
/// [bguProtein] - Белок.
/// [bguFat] - Жиры.
/// [bguCarb] - Углеводы.
class PropertiesMenuItem {
  PropertiesMenuItem({
    this.labels,
    this.mainLabel,
    this.cookTime,
    this.weight,
    this.ratio,
    this.willDeliver,
    this.youNeed,
    this.prepareComment,
    this.bguCal,
    this.bguProtein,
    this.bguFat,
    this.bguCarb,
  });

  final List<MenuItemLabel> labels;
  final MenuItemMainLabel mainLabel;
  final int cookTime;
  final int weight;
  final int ratio;
  final String willDeliver;
  final String youNeed;
  final String prepareComment;
  final double bguCal;
  final double bguProtein;
  final double bguFat;
  final double bguCarb;

  /// Переводим минуты в удобночитаемое время
  String get cookTimeUi => cookTime == null
      ? ellipsisText
      : TimeFormatter.formatToString(
          TimeDuration.fromMinutes(cookTime),
          isShort: true,
        );

  /// Колличество порций и вес
  String get portionUi {
    final res = ratio == null ? emptyString : '$ratio x';
    return weight == null || ratio == null
        ? ellipsisText
        : '$res ${weight ~/ ratio} $gramText';
  }

  /// Колличество порций и вес блок Для вас
  String get portionForYouUi {
    var res = '';
    if(ratio == null){
      res = emptyString;
    }else if(ratio == 1){
      res = '$ratio-го:';
    }else if(ratio > 1 && ratio < 4){
      res = '$ratio-их:';
    }else{
      res = '$ratio-ых:';
    }
    return weight == null || ratio == null
        ? ellipsisText
        : '$res ${weight ~/ ratio} $gramText';
  }
}
