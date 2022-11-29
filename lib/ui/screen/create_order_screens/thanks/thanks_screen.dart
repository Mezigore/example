import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/button_styles.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/thanks/di/thanks_screen_component.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/thanks/thanks_screen_wm.dart';

import '../../../res/colors.dart';

/// Экран успешного оформления заказа
class ThanksScreen extends MwwmWidget<ThanksScreenComponent> {
  ThanksScreen({
    Key key,
    bool isPayed,
    int ordersCount,
  }) : super(
    widgetModelBuilder: createThanksScreenWidgetModel,
    dependenciesBuilder: (context) => ThanksScreenComponent(context),
    widgetStateBuilder: () => _ThanksScreenState(isPayed ?? false, ordersCount ?? 1),
    key: key,
  );
}

class _ThanksScreenState extends WidgetState<ThanksScreenWidgetModel> {
  // ignore: avoid_positional_boolean_parameters
  _ThanksScreenState(this.isPayed, this.ordersCount);

  final bool isPayed;
  final int ordersCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector
          .of<ThanksScreenComponent>(context)
          .component
          .scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                child: _TitleWidget(wm: wm, ordersCount: ordersCount,),
              ),

              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: wm.openCatalogAction,
                  style: accentButtonStyle.style,
                  child: const Text(createOrderOpenCatalog),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({
    Key key,
    bool isPayed,
    this.wm,
    this.ordersCount,
  })
      : isPayed = isPayed ?? false,
        super(key: key);

  final bool isPayed;
  final ThanksScreenWidgetModel wm;
  final int ordersCount;

  @override
  Widget build(BuildContext context) {
    print(ordersCount);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SvgPicture.asset(
                icLogo,
                height: 48,
                width: 99,
              ),
              const SizedBox(height: 48),
              Text(
                createOrderThanks,
                style: textMedium32,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if(ordersCount == 0)...[
                const _RichTextWidget(),
              ]else...[
                Text(
                  isPayed ? createOrderAlreadyPayedTitle : createOrderMayBePayedTitle,
                  style: textRegular16,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 32),
        if(ordersCount == 0)...[
          const _DiscountWidget(),
        ]else...[
          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: wm.openOrdersAction,
              child: const Text(createOrderOpenOrders),
            ),
          ),
        ],

        const SizedBox(height: 16),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: wm.openRecipesAction,
            child: const Text(createOrderOpenRecipes),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: wm.openDiscountAction,
            style: accentButtonStyle.style,
            child: const Text(createOrderOpenDiscount),
          ),
        ),
      ],
    );
  }
}

class _DiscountWidget extends StatelessWidget {
  const _DiscountWidget({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: premiumLabelBorderColor,),),
      padding: const EdgeInsets.only(top: 20, bottom: 60,right: 60, left: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            icPercentStar,
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(createOrderDiscontTitle, style: textMedium16,),
                const SizedBox(height: 8,),
                Text(createOrderDiscontText, style: textRegular14Secondary,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _RichTextWidget extends StatelessWidget {
  const _RichTextWidget({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textRegular20,
        children: <TextSpan>[
          const TextSpan(text: createOrderFirstOrderTitle1),
          TextSpan(text: createOrderFirstOrderTitle2, style: textRegular20Accent),
        ],
      ),
    );
  }
}