import 'package:flutter/material.dart' hide Action, MenuItem;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/ui/screen/main/widget/cards/common_dish_card.dart';
import 'package:uzhindoma/ui/screen/main/widget/cards/extra_dish_card.dart';
import 'package:uzhindoma/ui/screen/main/widget/cards/premium_dish_card.dart';

/// Карточка виджета блюда.
class DishCard extends StatelessWidget {
  const DishCard({
    @required this.isBigCards,
    @required this.categoryName,
    @required this.menuItem,
    @required this.selectCardAction,
    Key key,
  })  : assert(isBigCards != null),
        assert(categoryName != null),
        assert(menuItem != null),
        assert(selectCardAction != null),
        super(key: key);

  final int isBigCards;
  final String categoryName;
  final MenuItem menuItem;
  final Action<MenuItem> selectCardAction;

  @override
  Widget build(BuildContext context) {
    Widget child;

    if(isBigCards == 0){
      child = ExtraDishCard(menuItem: menuItem);
    } else {
      child = CommonDishCard(menuItem: menuItem, categoryName: categoryName);
    }
    // switch (menuItem.type) {
    //   case MenuItemType.premium:
    //     child = PremiumDishCard(menuItem: menuItem);
    //     break;
    //   case MenuItemType.extra:
    //     child = ExtraDishCard(menuItem: menuItem);
    //     break;
    //   case MenuItemType.common:
    //   default:
    //     child = CommonDishCard(menuItem: menuItem);
    // }

    return GestureDetector(
      onTap: () => selectCardAction.accept(menuItem),
      child: child,
    );
  }
}
