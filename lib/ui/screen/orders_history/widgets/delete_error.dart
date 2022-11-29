import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

abstract class DeleteError {
  static void showWarningWithWhatsApp({
    BuildContext context,
  }) {
    showModalBottomSheet<bool>(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (_) => BottomSheetContainer(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'До доставки осталось менее 2 дней. Заказ можно отменить:',
                      style: textMedium16,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '• через личного менеджера,',
                      style: textRegular16,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () => launch(
                          'https://api.whatsapp.com/send/?phone=79161704385&text=%D0%9F%D1%80%D0%B8%D0%B2%D0%B5%D1%82%2C+%D1%85%D0%BE%D1%87%D1%83+%D0%BE%D1%82%D0%BC%D0%B5%D0%BD%D0%B8%D1%82%D1%8C+%D1%81%D0%B2%D0%BE%D0%B9+%D0%B7%D0%B0%D0%BA%D0%B0%D0%B7%21+%D0%9F%D0%BE+%D0%BF%D1%80%D0%B8%D1%87%D0%B8%D0%BD%D0%B5+...&type=phone_number&app_absent=0'),
                      child: RichText(
                        text: TextSpan(
                          style: textRegular16,
                          children: const <TextSpan>[
                            TextSpan(
                              text: '• или написав в ',
                            ),
                            TextSpan(
                              text: 'WhatsApp',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(
                              text: '.',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: secondaryFullColor),
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text(
                            'Закрыть',
                            style: TextStyle(
                              color: activeFullColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
