import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Дефолтный аппбар
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    Key key,
    this.leadingIcon,
    this.title,
    this.actions,
    this.onLeadingTap,
  }) : super(key: key);

  final IconData leadingIcon;
  final String title;
  final List<Widget> actions;
  final VoidCallback onLeadingTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: actions,
      backgroundColor: backgroundColor,
      centerTitle: true,
      leading: IconButton(
        splashRadius: 20,
        onPressed: onLeadingTap ?? () => Navigator.of(context).canPop()? Navigator.of(context).pop(): Navigator.of(context).pushReplacementNamed('/'),
        icon: Icon(
          leadingIcon,
          color: closeIconColor,
        ),
      ),
      title: title != null
          ? Text(
              title,
              style: textMedium16,
            )
          : null,
    );
  }
}
