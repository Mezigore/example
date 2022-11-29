import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/main/main_screen_route.dart';

/// Рустой таб с рецептом
class RecipeEmptyTab extends StatelessWidget {
  const RecipeEmptyTab({
    Key key,
    this.isActualTab = true,
    this.isLikeTab = false,
  }) : super(key: key);

  final bool isActualTab;
  final bool isLikeTab;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      right: false,
      left: false,
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                isLikeTab? recipesLikeEmpty : isActualTab ? recipesActualEmpty : recipesOldEmpty,
                textAlign: TextAlign.center,
                style: textRegular16,
              ),
            ),
          ),
          if(!isLikeTab)...[
            AcceptButton(
              text: cartOpenCatalog,
              callback: () => Navigator.popUntil(
                context,
                    (route) => route.isFirst || route is MainScreenRoute,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
