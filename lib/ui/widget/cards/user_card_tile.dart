import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/common/widgets/svg_icon_button.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Элемент списка карт
class UserCardTile extends StatelessWidget {
  const UserCardTile({
    Key key,
    this.cardName,
    this.onDeleteTap,
  }) : super(key: key);
  final String cardName;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            cardName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textRegular16,
          ),
        ),
        SvgIconButton(
          icDelete,
          height: 54,
          width: 54,
          iconSize: 24,
          iconColor: deleteIconColor,
          onTap: onDeleteTap,
        ),
      ],
    );
  }
}

/// Элемент списка карт - состояние загрузки
class UserCardTileLoader extends StatelessWidget {
  const UserCardTileLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        children: const [
          SkeletonWidget(
            height: 16,
            width: 160,
            radius: 16,
            isLoading: true,
          ),
          Spacer(),
          SkeletonWidget(
            height: 16,
            width: 16,
            radius: 16,
            isLoading: true,
          ),
        ],
      ),
    );
  }
}
