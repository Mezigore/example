import 'package:flutter/material.dart' hide Action;
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Боттомшит Promo.
class PromoErrBottomSheet extends StatelessWidget {
  const PromoErrBottomSheet({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              promoScreenBottomSheetTitle,
              style: textMedium16,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9.0, bottom: 32.0),
              child: Text(
                promoScreenBottomSheetTempContent,
                style: textRegular14,
              ),
            ),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).popAndPushNamed('/'),
                child: const Text(promoScreenBottomSheetCloseButtonText),
              ),
            )
          ],
        ),
      ),
    );
  }
}