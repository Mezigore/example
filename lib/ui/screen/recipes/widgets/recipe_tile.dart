import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uzhindoma/domain/core.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/actual/actual_recipes_tab_wm.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/like/like_recipe_tab_wm.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/old/old_recipes_tab_wm.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';
import 'package:uzhindoma/ui/widget/product/product_info.dart';

import '../../../res/strings/strings.dart';

/// Ячейка списка с рецептом
class RecipeTile extends StatelessWidget {
  const RecipeTile({
    Key key,
    @required this.recipe,
    this.isArchived = true,
    this.onTap,
    this.isShowLikeBtn,
    this.actual,
    this.like,
    this.wmTapActual,
    this.wmTapOld,
    this.wmTapLike,
  })  : assert(recipe != null),
        super(key: key);
  final Recipe recipe;
  final bool isArchived;
  final VoidCallback onTap;
  final bool isShowLikeBtn;
  final bool actual;
  final bool like;
  final ActualRecipesTabWidgetModel wmTapActual;
  final OldRecipesTabWidgetModel wmTapOld;
  final LikeRecipesTabWidgetModel wmTapLike;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap ??
              () {
                if(actual && recipe.toShow || !actual){
                  Navigator.pushNamed(
                    context,
                    AppRouter.recipeDetail,
                    arguments: Pair(recipe, isArchived),
                  );
                }
              },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                _ImageWidget(
                  imageUrl: recipe.previewImg,
                  isShowLikeBtn: isShowLikeBtn,
                  wmTapActual: wmTapActual,
                  wmTapOld: wmTapOld,
                  wmTapLike: wmTapLike,
                  actual: actual,
                  like: like,
                  isLikeNow: recipe.isFavorite,
                  productId: recipe.productId,
                ),
                const SizedBox(width: 12),
              if(actual && recipe.toShow || !actual)...[
                _InfoWidget(recipe: recipe),
              ],
               if (actual && !recipe.toShow) ...[
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: Text(
                      recipesNotAvailable,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: textRegular14,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if(actual && !recipe.toShow)...[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: Colors.black.withOpacity(0.6),
                  ),
                  child: Center(
                    child: SvgPicture.asset(icLock),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _ImageWidget extends StatefulWidget {
  const _ImageWidget({
    Key key,
    @required this.imageUrl,
    @required this.productId,
    this.isShowLikeBtn,
    this.isLikeNow = false,
    this.actual,
    this.like,
    this.wmTapActual,
    this.wmTapOld,
    this.wmTapLike,
  })  : assert(imageUrl != null),
        super(key: key);

  final String imageUrl;
  final String productId;
  final bool isShowLikeBtn;
  final bool isLikeNow;
  final bool actual;
  final bool like;
  final ActualRecipesTabWidgetModel wmTapActual;
  final OldRecipesTabWidgetModel wmTapOld;
  final LikeRecipesTabWidgetModel wmTapLike;

  @override
  __ImageWidgetState createState() => __ImageWidgetState();
}

class __ImageWidgetState extends State<_ImageWidget> {
  Color get activeColor =>
      /*isFull ? */ activeDiscountFullColor /*: secondaryDiscountFullColor*/;

  bool isLikeNow = false;

  @override
  void initState() {
    isLikeNow = widget.isLikeNow;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 128,
      child: Stack(
        children: [
          SizedBox(
            width: 128,
            height: 128,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: ProductImageWidget(
                urlImage: widget.imageUrl,
                boxFit: BoxFit.fitHeight,
              ),
            ),
          ),
          widget.isShowLikeBtn
              ? InkWell(
                  onTap: () {
                    if (widget.isLikeNow) {
                      if (widget.like) {
                        widget.wmTapLike.unlikeAction(widget.productId);
                      } else {
                        widget.actual ? widget.wmTapActual.unlikeAction(widget.productId) : widget.wmTapOld.unlikeAction(widget.productId);
                      }
                    } else {
                      if (widget.like) {
                        widget.wmTapLike.likeAction(widget.productId);
                      } else {
                        widget.actual ? widget.wmTapActual.likeAction(widget.productId) : widget.wmTapOld.likeAction(widget.productId);
                      }
                    }
                    setState(() {
                      isLikeNow = !isLikeNow;
                    });
                    // actual? wmTapActual.reloadState : wmTapOld.reloadState;
                  },
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    // Positioned(
                    // left: -20,
                    // bottom: -20,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(50)),
                        color: Colors.white,
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 0, bottom: 0),
                        child: Icon(
                          isLikeNow ? Icons.favorite : Icons.favorite_border,
                          color: activeColor,
                          size: 27,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class _InfoWidget extends StatelessWidget {
  const _InfoWidget({
    Key key,
    @required this.recipe,
  })  : assert(recipe != null),
        super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _TitleProduct(title: recipe.name),
          const SizedBox(height: 12),
          ProductInfoWidget(
            cookingTime: recipe.cookTimeUi,
            portion: recipe.portionUi,
            fontSize: 12,
            iconSize: 16,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              SvgPicture.asset(icRate, height: 15,),
              const SizedBox(width: 6,),
              Text(recipe.rate.toString(), style: textRegular12,),
            ],
          )
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
