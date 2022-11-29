import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/widget/common/loading_widget.dart';
import 'package:uzhindoma/util/const.dart';

/// Текстовое поле для нажатия
class OrderTapField extends StatelessWidget {
  const OrderTapField({
    Key key,
    this.text,
    this.onTap,
    bool isLoading,
  })  : isLoading = isLoading ?? false,
        super(key: key);

  final bool isLoading;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: textFormFieldFillColor,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 56,
          alignment: Alignment.center,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isLoading
                    ? const LoadingWidget()
                    : Text(
                        text ?? emptyString,
                        style: textRegular16,
                      ),
                SvgPicture.asset(icArrowRight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
