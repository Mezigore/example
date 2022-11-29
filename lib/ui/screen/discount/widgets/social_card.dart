import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: premiumLabelBorderColor)
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(discountSocialCardGetBonusesText, style: textMedium24.copyWith(height: 1.7),),
          ],),
          const SizedBox(height: 20,),
          Text(discountSocialCardSharedLinkText, style: textRegular16.copyWith(fontSize: 18, height: 1.7),),
          const SizedBox(height: 20,),
          InkWell(
            onTap: (){},
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: textColorPrimary),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                discountSocialCardCopyLinkText, style: textRegular16,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Text(discountSocialCardInfoText, style:  textRegular14.copyWith(color: barrierColor, height: 1.7),),
          const SizedBox(height: 30,),
          Text(discountSocialCardSharedScialLinkText, style: textRegular16.copyWith(fontSize: 18),),
          const SizedBox(height: 70,),
          Row(
            children: [
              Text(discountSocialCardFriendsText, style: textRegular14.copyWith(color: barrierColor),),
              const Text('0'),
            ],
          ),
          const SizedBox(height: 15,),
        ],
      ),
    );
  }
}
