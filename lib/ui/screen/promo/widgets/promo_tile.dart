import 'package:flutter/material.dart' hide MenuItem;
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/domain/core.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/actual/actual_recipes_tab_wm.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/old/old_recipes_tab_wm.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/like/like_recipe_tab_wm.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';
import 'package:uzhindoma/ui/widget/product/product_info.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../promo_screen_wm.dart';

/// Ячейка списка с рецептом
class PromoTile extends StatelessWidget {
  const PromoTile({
    Key key,
    @required this.promoItem,
    this.isArchived = true,
    this.onTap,
    this.isShowLikeBtn,
    this.actual,
    this.like,
    this.wmTap,
  })  : assert(promoItem != null),
        super(key: key);
  final MenuItem promoItem;
  final bool isArchived;
  final VoidCallback onTap;
  final bool isShowLikeBtn;
  final bool actual;
  final bool like;
  final PromoScreenWidgetModel wmTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => wmTap.selectCardAction.accept(promoItem),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: [
            _ImageWidget(
              imageUrl: promoItem.previewImg,
            ),
            const SizedBox(width: 12),
            _InfoWidget(promoItem: promoItem),
          ],
        ),
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({Key key, @required this.imageUrl})
      : assert(imageUrl != null),
        super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      width: 128,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: ProductImageWidget(
          urlImage: imageUrl,
        ),
      ),
    );
  }
}

class _InfoWidget extends StatelessWidget {
  const _InfoWidget({
    Key key,
    @required this.promoItem,
  })  : assert(promoItem != null),
        super(key: key);
  final MenuItem promoItem;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _TitleProduct(title: promoItem.name),
          const SizedBox(height: 12),
          ProductInfoWidget(
            cookingTime: promoItem.properties.cookTimeUi,
            portion: promoItem.properties.portionUi,
            fontSize: 12,
            iconSize: 16,
          ),
          const SizedBox(
            height: 16,
          ),
          // Row(
          //   children: [
          //     SvgPicture.asset(icRate, height: 15,),
          //     const SizedBox(width: 6,),
          //     Text(promoItem.properties.rate.toString(), style: textRegular12,),
          //   ],
          // )
        ],
      ),
    );
  }
}

class _TitleProduct extends StatelessWidget {
  const _TitleProduct({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: textRegular14,
    );
  }
}
