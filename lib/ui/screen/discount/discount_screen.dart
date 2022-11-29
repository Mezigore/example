import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/user/user_info.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/profile/di/profile_component.dart';
import 'package:uzhindoma/ui/screen/profile/profile_wm.dart';

class DiscountScreen extends MwwmWidget<ProfileComponent> {
  DiscountScreen({
    Key key,
  }) : super(
    key: key,
    widgetModelBuilder: createProfileWm,
    dependenciesBuilder: (context) => ProfileComponent(context),
    widgetStateBuilder: () => _DiscountScreenState(),
  );
}

class _DiscountScreenState extends WidgetState<ProfileWidgetModel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: const DefaultAppBar(
          title: discountMainText,
          leadingIcon: Icons.arrow_back_ios,
        ),
        body: SingleChildScrollView(
          child: StreamedStateBuilder<EntityState<UserInfo>>(
              streamedState: wm.userState,
              builder: (context, entity) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Text(
                            discountBonusesOnAccountText,
                            style: textMedium24,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          entity.data != null
                              ? Text(
                            entity.data.bonus.toString(),
                            style: textMedium32,
                          )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            discountSocialCardFriendsText,
                            style: textRegular14.copyWith(color: barrierColor),
                          ),
                          entity.data != null ? Text(entity.data.promocode.useCount.toString()) : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        discountSocialCardInfoText,
                        style: textRegular14.copyWith( height: 1.6),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: premiumLabelBorderColor)),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              discountSocialCardBonusesForFriendText,
                              style: textMedium18.copyWith(height: 1.5,),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        discountSocialCard500Text,
                                      style: textMedium18.copyWith(height: 1.5,),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                        discountSocialCardBonusesText,
                                      style: textRegular14,
                                    )
                                  ],
                                ),
                                const SizedBox(width: 42,),
                                Text(
                                    discountSocialCardFirstOrderText,
                                  style: textMedium14,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  '5%',
                                  style: textMedium18.copyWith(height: 1.5,),
                                ),
                                const SizedBox(width: 72,),
                                Text(
                                  discountSocialCardFromAmountText,
                                  style: textMedium14,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      discountSocialCard84Text,
                                      style: textMedium18.copyWith(height: 1.5,),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      discountSocialCardDaysText,
                                      style: textRegular14,
                                    )
                                  ],
                                ),
                                const SizedBox(width: 74,),
                                Text(
                                  discountSocialCardYouGetBonusesText,
                                  style: textMedium14,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (entity.data != null) {
                                  wm.onShareButtonTap();
                                 }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  color: buttonAccentColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'res/assets/icons/ic_share.svg',
                                      color: Colors.white,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      discountSocialCardShareButtonText,
                                      style: textRegular16White.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        textBaseline: TextBaseline.ideographic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
