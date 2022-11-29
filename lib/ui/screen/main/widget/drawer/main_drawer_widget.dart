import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uzhindoma/config/config.dart';
import 'package:uzhindoma/config/env/env.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/main/widget/drawer/di/main_drawer_component.dart';
import 'package:uzhindoma/ui/screen/main/widget/drawer/main_drawer_wm.dart';

/// Реализация бургер-меню основного экрана приложения.
class MainDrawerWidget extends MwwmWidget<MainDrawerComponent> {
  MainDrawerWidget({
    Key key,
  }) : super(
          key: key,
          widgetModelBuilder: createMainDrawerWm,
          dependenciesBuilder: (context) => MainDrawerComponent(context),
          widgetStateBuilder: () => _MainDrawerWidgetState(),
        );
}

class _MainDrawerWidgetState extends WidgetState<MainDrawerWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderDrawer(),
            const Divider(),
            const SizedBox(height: 20),
            _Button(
              title: ordersMainDrawerWidgetText,
              action: wm.ordersAction,
              pathSvg: icOrders,
            ),
            _Button(
              title: recipesMainDrawerWidgetText,
              action: wm.recipesAction,
              pathSvg: icRecipes,
            ),
            _Button(
              title: discountMainDrawerWidgetText,
              action: wm.discountAction,
              pathSvg: icDiscount,
            ),
            _Button(
              title: profileMainDrawerWidgetText,
              action: wm.profileAction,
              pathSvg: icProfile,
            ),
            _Button(
              title: aboutServiceMainDrawerWidgetText,
              action: wm.aboutServiceAction,
              pathSvg: icAboutService,
            ),
            const SizedBox(height: 12),
            const Spacer(),
            _CallToWidget(action: wm.callToAction),
            _LogOut(
              logoutAction: wm.logoutAction,
            )
          ],
        ),
      ),
    );
  }
}

class _CallToWidget extends StatelessWidget {
  const _CallToWidget({
    Key key,
    this.action,
  }) : super(key: key);

  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Row(
        children: [
          const SizedBox(width: 20),
          InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onTap: action,
            child: SvgPicture.asset(icCallTo),
          ),
          const SizedBox(width: 20),
          InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onTap: () => launch(
                'https://wa.me/79161704385?text=%D0%9F%D1%80%D0%B8%D0%B2%D0%B5%D1%82!%20'),
            child: SvgPicture.asset(icCallToWhatApp, height: 32, width: 32,),
          ),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                callToMainDrawerWidgetText,
                style: textMedium16Accent,
              ),
              Text(
                everyDayMainDrawerWidgetText,
                style: textRegular12Secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget uzdIcon = SvgPicture.asset(
      icDinnerAtHome,
      height: 71,
      width: 148,
    );

    if (!Environment<Config>.instance().isRelease) {
      uzdIcon = GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(AppRouter.debug);
        },
        child: uzdIcon,
      );
    }

    return Expanded(
      flex: 3,
      child: Center(
        child: uzdIcon,
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key key,
    @required this.action,
    @required this.title,
    @required this.pathSvg,
  })  : assert(action != null),
        assert(title != null),
        assert(pathSvg != null),
        super(key: key);
  final VoidCallback action;
  final String title;
  final String pathSvg;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: action,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                SvgPicture.asset(pathSvg),
                const SizedBox(width: 24),
                Text(
                  title,
                  style: textRegular16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogOut extends StatelessWidget {
  const _LogOut({Key key, this.logoutAction}) : super(key: key);
  final VoidCallback logoutAction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          InkWell(
            onTap: logoutAction,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 14, bottom: 16),
              child: Center(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    logoutMainDrawerWidgetText,
                    style: textMedium16Hint,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
