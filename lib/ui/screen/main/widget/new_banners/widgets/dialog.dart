import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';

abstract class BannersDialog {

  static void showBannerCopyInfoDialog({
    String promocode,
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
              children: [
                Text(
                    copyTextDialog1 + promocode + copyTextDialog2,
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
                        copyTextDialogBtn,
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