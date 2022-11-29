import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

///alert диалог, который сам проверяет платформу
class PlatformAlertDialog extends StatelessWidget {
  const PlatformAlertDialog({
    Key key,
    this.alertText,
    this.agreeButtonText,
    this.disagreeButtonText,
    this.onAgreeClicked,
    this.onDisagreeClicked,
  }) : super(key: key);

  final String alertText;
  final String agreeButtonText;
  final String disagreeButtonText;
  final VoidCallback onAgreeClicked;
  final VoidCallback onDisagreeClicked;

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;

    return platform == TargetPlatform.iOS
        ? _buildCupertinoDialog()
        : _buildMaterialDialog();
  }

  Widget _buildCupertinoDialog() {
    return CupertinoAlertDialog(
      title: Text(alertText),
      actions: <Widget>[
        onDisagreeClicked != null
            ? TextButton(
                onPressed: onDisagreeClicked,
                child: Text(disagreeButtonText ?? cancelText),
              )
            : Container(),
        TextButton(
          onPressed: onAgreeClicked,
          child: Text(agreeButtonText ?? okText),
        )
      ],
    );
  }

  Widget _buildMaterialDialog() {
    return AlertDialog(
      title: Text(
        alertText,
        style: textRegular16,
      ),
      actions: <Widget>[
        onDisagreeClicked != null
            ? TextButton(
                onPressed: onDisagreeClicked,
                child: Text(disagreeButtonText ?? cancelText),
              )
            : Container(),
        TextButton(
          onPressed: onAgreeClicked,
          child: Text(agreeButtonText ?? okText),
        )
      ],
    );
  }
}
