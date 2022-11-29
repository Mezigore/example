import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/user/user_info.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/profile/di/profile_component.dart';
import 'package:uzhindoma/ui/screen/profile/profile_placeholder.dart';
import 'package:uzhindoma/ui/screen/profile/profile_wm.dart';
import 'package:uzhindoma/ui/screen/profile/tabs/addresses/addresses_tab.dart';
import 'package:uzhindoma/ui/screen/profile/tabs/cards/cards_tab.dart';
import 'package:uzhindoma/ui/screen/profile/tabs/user_details/user_details_widget.dart';
import 'package:uzhindoma/ui/widget/error/error.dart';

/// Высота табов
const double heightTabsProfile = 53;

/// Screen [ProfileScreen] - экран профиля пользователя
class ProfileScreen extends MwwmWidget<ProfileComponent> {
  ProfileScreen({
    Key key,
  }) : super(
          key: key,
          widgetModelBuilder: createProfileWm,
          dependenciesBuilder: (context) => ProfileComponent(context),
          widgetStateBuilder: () => _ProfileScreenState(),
        );
}

class _ProfileScreenState extends WidgetState<ProfileWidgetModel> {
  final tabs = TabBarView(
    children: [
      UserDetailsWidget(),
      AddressesTab(),
      CardsTab(),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: tabs.children.length,
        child: Scaffold(
          key: wm.scaffoldKey,
          backgroundColor: white,
          appBar: AppBar(
            title: Text(
              profileScreenProfileText,
              style: textMedium16,
            ),
            backgroundColor: white,
            centerTitle: true,
            elevation: 0,
            leading: Center(
              child: IconButton(
                splashRadius: 24,
                onPressed: wm.onBackAction,
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: Colors.black87,
                ),
              ),
            ),
            bottom: _TabsProfile(
              userState: wm.userState,
            ),
          ),
          body: StreamedStateBuilder<EntityState<UserInfo>>(
            streamedState: wm.userState,
            builder: (context, entity) {
              if (entity.data == null) {
                if (entity.isLoading) return const ProfilePlaceholder();
                if (entity.hasError) {
                  return ErrorStateWidget(
                    onReloadAction: wm.onReloadAction,
                  );
                }
              }
              return tabs;
            },
          ),
        ),
      ),
    );
  }
}

class _TabsProfile extends StatelessWidget implements PreferredSizeWidget {
  const _TabsProfile({
    Key key,
    @required this.userState,
  })  : assert(userState != null),
        super(key: key);

  final EntityStreamedState<UserInfo> userState;

  @override
  Size get preferredSize => const Size(
        double.infinity,
        heightTabsProfile,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 2,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: tabBarLineColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(1),
                  ),
                ),
              ),
            ),
          ),
          StreamedStateBuilder<EntityState<UserInfo>>(
            streamedState: userState,
            builder: (context, entity) {
              if (entity.data == null) {
                if (entity.isLoading) return const _TabBarProfile(isLoad: true);
              }
              return const _TabBarProfile(isLoad: false);
            },
          ),
        ],
      ),
    );
  }
}

class _TabBarProfile extends StatelessWidget {
  const _TabBarProfile({
    Key key,
    @required bool isLoad,
  })  : isLoad = isLoad ?? true,
        super(key: key);

  final bool isLoad;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelStyle: textMedium12,
      unselectedLabelColor: textColorHint,
      labelColor: textColorAccent,
      labelPadding: EdgeInsets.zero,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 3.0,
          color: textColorAccent,
        ),
      ),
      tabs: isLoad
          ? const [
              SkeletonAppBar(),
              SkeletonAppBar(),
              SkeletonAppBar(),
            ]
          : const [
              Tab(text: profileScreenMyDetailsText),
              Tab(text: profileScreenAddressesText),
              Tab(text: profileScreenPaymentText),
            ],
    );
  }
}
