import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/main/main_screen_route.dart';

/// Заглушка пустой истории заказов
class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({Key key}) : super(key: key);

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
                orderEmpty,
                textAlign: TextAlign.center,
                style: textRegular16,
              ),
            ),
          ),
          AcceptButton(
            text: cartOpenCatalog,
            callback: () => Navigator.popUntil(
              context,
              (route) => route.isFirst || route is MainScreenRoute,
            ),
          ),
        ],
      ),
    );
  }
}
