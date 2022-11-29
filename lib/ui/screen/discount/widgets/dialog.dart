import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

abstract class BonusDialog {

  static void showDeleteDeviceDialog({
    BuildContext context,
  }) {
    showModalBottomSheet<bool>(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (_) => BottomSheetContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Больше бонусов!',
                //   style: textMedium24,
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                Text(
                  'Для получения бонусов Вы можете:',
                  style: textMedium16,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '1) Пригласить друзей',
                  style: textRegular16,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '2) Участвовать в конкурсах в наших соц.сетях',
                  style: textRegular16,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '1 бонус = 1 рублю.',
                  style: textRegular16Grey.copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Вы можете оплатить ими весь заказ',
                  style: textRegular16Grey.copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), color: secondaryFullColor),
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