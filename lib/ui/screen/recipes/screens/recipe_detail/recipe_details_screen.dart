import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/recipes/screens/recipe_detail/di/recipe_details_screen_component.dart';
import 'package:uzhindoma/ui/screen/recipes/screens/recipe_detail/recipe_details_screen_wm.dart';
import 'package:uzhindoma/ui/widget/common/loading_widget.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';
import 'package:uzhindoma/ui/widget/product/product_info.dart';
import 'package:wakelock/wakelock.dart';

/// Детальое описание рецепта
class RecipeDetailsScreen extends MwwmWidget<RecipeDetailsScreenComponent> {
  RecipeDetailsScreen({
    Key key,
    Recipe recipe,
    bool isArchived,
  }) : super(
          key: key,
          widgetStateBuilder: () => _RecipeDetailsScreenState(),
          dependenciesBuilder: (context) =>
              RecipeDetailsScreenComponent(context),
          widgetModelBuilder: (context) => createRecipeDetailsScreenWidgetModel(
            context,
            recipe,
            isArchived,
          ),
        );
}

class _RecipeDetailsScreenState
    extends WidgetState<RecipeDetailsScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<RecipeDetailsScreenComponent>(context)
          .component
          .scaffoldKey,
      appBar: DefaultAppBar(
        leadingIcon: Icons.arrow_back_ios,
        title: recipesDetailTitle,
        onLeadingTap: (){
          Wakelock.disable();
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: ProductImageWidget(
                urlImage: wm.recipe.detailImg ?? wm.recipe.previewImg,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wm.recipe.name,
                    style: textMedium18,
                  ),
                  const SizedBox(height: 20),
                  ProductInfoWidget(
                    cookingTime: wm.recipe.cookTimeUi,
                    portion: wm.recipe.portionUi,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 32),
                  if (!wm.isArchived) _CookBefore(recipe: wm.recipe),
                  const _Divider(heightTop: 16, heightBottom: 17),
                  _BguWidget(recipe: wm.recipe),
                  const _Divider(heightTop: 21, heightBottom: 24),
                  _IngredientsWidget(
                    title: recipeIngredients,
                    info: wm.recipe.willDeliver,
                  ),
                  const SizedBox(height: 24),
                  _InfoWidget(
                    title: youWillNeedProductDetailsWidgetText,
                    info: wm.recipe.youNeed,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    recipesDetailTitle,
                    style: textMedium16,
                  ),
                  _RecipeTable(recipe: wm.recipe),
                  const SizedBox(height: 48),
                  if (!wm.isArchived)
                    StreamedStateBuilder<bool>(
                        streamedState: wm.isLoadingState,
                        builder: (context, isLoading) {
                          return _RateButton(
                            recipe: wm.recipe,
                            onTap: wm.doneAction,
                            isLoading: isLoading ?? false,
                          );
                        }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _LoadingAnimation extends StatelessWidget {
  const _LoadingAnimation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: LoadingWidget());
  }
}

class _RateButton extends StatefulWidget {
  const _RateButton({
    Key key,
    this.recipe,
    this.onTap,
    this.isLoading,
  }) : super(key: key);
  final Recipe recipe;
  final ValueChanged<int> onTap;
  final bool isLoading;

  @override
  State<StatefulWidget> createState() => _RateState();
}

class _RateState extends State<_RateButton> {
  List<bool> rate = [];

  @override
  void initState() {
    if(widget.recipe.rate > 0){
      if(widget.recipe.rate<5){
        rate = List.filled(widget.recipe.rate, true);
        for(int i = 0; i< 5-widget.recipe.rate; i++){
          rate.add(false);
        }
      }else{
        rate = List.filled(5, true);
      }
    }else{
      rate = List.filled(5, false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: Container(
        height: 106,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          color: bannerPrimary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              recipesBtnRate,
              style: textRegular16Secondary,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 250,
              height: 30,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: widget.recipe.rate != 0
                        ? null
                        : () {
                            // rate = [false, false, false, false, false];
                            for (int i = 0; i <= index; i++) {
                              setState(() {
                                rate[i] = true;
                              });
                            }
                            widget.onTap.call(index + 1);
                          },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SvgPicture.asset(
                        icRate,
                        height: 30,
                        color: rate[index]? null:rateDisableColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _DoneButton extends StatelessWidget {
//   const _DoneButton({
//     Key key,
//     this.onTap,
//     this.isLoading,
//   }) : super(key: key);
//   final VoidCallback onTap;
//   final bool isLoading;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       left: false,
//       right: false,
//       top: false,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 16.0),
//         child: SizedBox(
//           height: 56,
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: (isLoading ?? false) ? null : onTap,
//             child: (isLoading ?? false)
//                 ? const _LoadingAnimation()
//                 : const Text(recipesBtnDone),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _RecipeTable extends StatelessWidget {
  const _RecipeTable({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: recipe?.recipes
              ?.map(
                (stage) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (stage.step != null)
                        SizedBox(
                          width: 24,
                          child:
                              Text(stage.step.toString(), style: textMedium14),
                        ),
                      Expanded(child: Text(stage.descr, style: textRegular14)),
                    ],
                  ),
                ),
              )
              ?.toList() ??
          [],
    );
  }
}

class _CookBefore extends StatelessWidget {
  const _CookBefore({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 32,
      width: double.infinity,
      decoration: BoxDecoration(
        color: cookBeforeBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(recipe.dateTitle, style: textRegular14),
    );
  }
}

/// Ингредиенты
class _IngredientsWidget extends StatelessWidget {
  const _IngredientsWidget({
    Key key,
    @required this.title,
    @required this.info,
  }) : super(key: key);

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: textMedium16,
        ),
        const SizedBox(height: 8),
        Text(
          (info == null || info.isEmpty) ? ellipsisText : info,
          style: textRegular14,
        ),
      ],
    );
  }
}

/// Дополнительная информация о продукте
class _InfoWidget extends StatelessWidget {
  const _InfoWidget({
    Key key,
    @required this.title,
    @required this.info,
  }) : super(key: key);

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: textMedium16,
        ),
        const SizedBox(height: 8),
        Text(
          (info == null || info.isEmpty) ? ellipsisText : info,
          style: textRegular14,
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key key,
    this.heightTop,
    this.heightBottom,
  }) : super(key: key);

  final double heightTop;
  final double heightBottom;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: heightTop),
        const Divider(),
        SizedBox(height: heightBottom),
      ],
    );
  }
}

class _BguWidget extends StatelessWidget {
  const _BguWidget({
    Key key,
    this.recipe,
  }) : super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const _BguInfoWidget(
          value: in100ProductDetailsWidgetText,
          type: productProductDetailsWidgetText,
        ),
        _BguInfoWidget(
          value: recipe.bguCal?.toString(),
          type: kcalProductDetailsWidgetText,
        ),
        _BguInfoWidget(
          value: recipe.bguProtein?.toString(),
          type: proteinProductDetailsWidgetText,
        ),
        _BguInfoWidget(
          value: recipe.bguFat?.toString(),
          type: fatProductDetailsWidgetText,
        ),
        _BguInfoWidget(
          value: recipe.bguCarb?.toString(),
          type: carbsProductDetailsWidgetText,
        ),
      ],
    );
  }
}

/// БЖУ продукта
class _BguInfoWidget extends StatelessWidget {
  const _BguInfoWidget({
    Key key,
    this.value,
    this.type,
  }) : super(key: key);
  final String value;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value ?? ellipsisText,
          style: textMedium14Secondary,
        ),
        Text(
          type,
          style: textRegular12Secondary,
        ),
      ],
    );
  }
}
