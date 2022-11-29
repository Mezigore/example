import 'package:flutter/material.dart' hide MenuItem;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/domain/catalog/menu/promo_item.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/promo/promo_screen_wm.dart';
import 'package:uzhindoma/ui/screen/promo/widgets/promo_error.dart';
import 'package:uzhindoma/ui/screen/promo/widgets/promo_loader.dart';
import 'package:uzhindoma/ui/screen/promo/widgets/promo_tile.dart';
import 'package:uzhindoma/util/currency_formatter.dart';

import 'di/promo_screen_component.dart';

/// Экран с промо набором
class PromoScreen extends MwwmWidget<PromoScreenComponent> {
  PromoScreen({Key key})
      : super(
    widgetModelBuilder: createPromoScreenWidgetModel,
    dependenciesBuilder: (context) => PromoScreenComponent(context),
    widgetStateBuilder: () => _PromoScreenState(),
    key: key,
  );
}

class _PromoScreenState extends WidgetState<PromoScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        leadingIcon: Icons.arrow_back_ios,
        title: promoScreenTitleText,
      ),
      body: EntityStateBuilder<PromoItem>(
        streamedState: wm.promoSetState,
        child: (_, list) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wm.promoSetState.value.data.appTitle,
                    style: textMedium24,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    // promoScreenAboutText,
                    wm.promoSetState.value.data.appDescription,
                    style: textRegular14,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _DateList(
                    promo: wm.promoSetState.value.data.products,
                    wmTap: wm,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20.0,
                    12.0,
                    20.0,
                    16.0,
                  ),
                  child: _Button(
                    onTap: wm.addPromoToCartAction,
                    text: promoScreenButtonText,
                    oldPrice: wm.promoSetState.value.data.params.oldPrice,
                    newPrice: wm.promoSetState.value.data.params.price,
                  ),
                ),
              ),),
          ],
        ),
        errorChild: PromoError(
          onUpdate: wm.reloadAction,
        ),
        loadingChild: _Loader(),
      ),
    );
  }
}

class _DateList extends StatelessWidget {
  const _DateList({
    Key key,
    @required this.promo,
    @required this.wmTap,
  })  :assert(promo != null),
        super(key: key);

  final List<MenuItem> promo;
  final PromoScreenWidgetModel wmTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: ListView.separated(
            itemCount: promo.length+1,
            itemBuilder: (context, i) {
              if(i == promo.length){
                return const SizedBox(height: 50,);
              }else{
                return PromoTile(
                  promoItem: promo[i],
                  isArchived: false,
                  isShowLikeBtn: true,
                  wmTap: wmTap,
                  actual: true,
                  like: false,
                );
              }

            },
            separatorBuilder: (_, i) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(color: dividerLightColor, height: 1),
              );
            },
          ),
    );
  }
}


class _Button extends StatelessWidget {
  const _Button({
    Key key,
    this.text,
    this.onTap,
    this.oldPrice,
    this.newPrice,
  })  :super(key: key);

  final VoidCallback onTap;
  final String text;
  final int oldPrice;
  final int newPrice;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        primary: cartButtonBackgroundColor,
        elevation: 0,
      ),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: textRegular16White),
            Row(
              children: [
                Text(
                  currencyFormatter(oldPrice),
                  style: textRegular16WhiteOpacityCross,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '${currencyFormatter(newPrice)} $rubleText',
                    style: textRegular16White,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 36),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: SkeletonWidget(
            isLoading: true,
            width: 152,
            height: 20,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 8, bottom: 12),
          child: SkeletonWidget(
            isLoading: true,
            height: 20,
            width: 216,
          ),
        ),
        Expanded(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (_, __) => const Padding(
              padding: EdgeInsets.all(20),
              child: PromoLoader(),
            ),
            separatorBuilder: (_, __) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 1,
                color: dividerLightColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
