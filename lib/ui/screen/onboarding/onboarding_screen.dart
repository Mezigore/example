import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/onboarding/onboarding_item.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

// ignore: always_use_package_imports
import 'di/onboarding_screen_component.dart';

// ignore: always_use_package_imports
import 'onboarding_screen_wm.dart';

/// Экран онбординга пользователя
class OnboardingScreen extends MwwmWidget<OnboardingScreenComponent> {
  OnboardingScreen({Key key})
      : super(
          widgetModelBuilder: createOnboardingScreenWidgetModel,
          dependenciesBuilder: (context) => OnboardingScreenComponent(context),
          widgetStateBuilder: () => _OnboardingScreenState(),
          key: key,
        );
}

class _OnboardingScreenState extends WidgetState<OnboardingScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:
          Injector.of<OnboardingScreenComponent>(context).component.scaffoldKey,
      body: Column(
        children: [
          const Spacer(flex: 76),
          Center(
            child: SvgPicture.asset(
              icLogo,
              height: 48.0,
            ),
          ),
          const Spacer(flex: 74),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: wm.tapAction,
            child: _OnBoardingContentWidget(
              pageController: wm.pageController,
              pageList: wm.pageList,
              pageState: wm.pageState,
            ),
          ),
          const Spacer(flex: 100),
          StreamedStateBuilder<int>(
            streamedState: wm.pageState,
            builder: (ctx, index) {
              return TextButton(
                onPressed: wm.skipAction,
                child: Text(index == wm.pageList.length - 1
                    ? startOnboardingButtonText
                    : skipOnboardingButtonText),
              );
            },
          ),
          const Spacer(flex: 50),
        ],
      ),
    );
  }
}

class _OnBoardingContentWidget extends StatelessWidget {
  _OnBoardingContentWidget({
    Key key,
    this.pageController,
    @required this.pageList,
    @required this.pageState,
  })  : assert(pageList != null && pageList.isNotEmpty),
        assert(pageState != null),
        super(key: key);

  final PageController pageController;
  final List<OnboardingItem> pageList;
  final StreamedState<int> pageState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamedStateBuilder<int>(
          streamedState: pageState,
          builder: (ctx, index) {
            return Text(
              pageList[index].title,
              style: textMedium24,
              textAlign: TextAlign.center,
            );
          },
        ),
        const SizedBox(height: 6.0),
        Stack(
          children: [
            Builder(
              // чтоы не подписывать от всего виджета на MQ
              builder: (context) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: pageController,
                  itemCount: pageList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      pageList[index].imagePath,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 21,
              left: 0,
              right: 0,
              child: StreamedStateBuilder<int>(
                streamedState: pageState,
                builder: (ctx, index) {
                  return _PageIndicator(
                    currentIndex: index,
                    totalCount: pageList.length,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    Key key,
    @required this.currentIndex,
    @required this.totalCount,
  })  : assert(totalCount != null && totalCount > 0),
        assert(currentIndex != null && currentIndex >= 0),
        assert(currentIndex <= totalCount - 1),
        super(key: key);

  final int currentIndex;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final list = <Widget>[];

    const selected = _PageIndicatorElement(isSelected: true);
    _PageIndicatorElement unselected;

    for (var i = 0; i < totalCount; i++) {
      if (i == currentIndex) {
        list.add(selected);
      } else {
        unselected ??= const _PageIndicatorElement();

        list.add(unselected);
      }

      if (i < totalCount - 1) {
        list.add(
          const SizedBox(width: 8.0),
        );
      }
    }

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: list,
      ),
    );
  }
}

class _PageIndicatorElement extends StatelessWidget {
  const _PageIndicatorElement({
    Key key,
    this.isSelected = false,
  }) : super(key: key);

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: isSelected ? buttonAccentColor : disableButton,
      ),
      height: 8.0,
      width: 8.0,
    );
  }
}
