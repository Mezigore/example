import 'package:flutter/cupertino.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';

/// Описание шага онбординга
class OnboardingItem {
  const OnboardingItem({
    @required this.title,
    @required this.imagePath,
  })  : assert(title != null),
        assert(imagePath != null);

  final String imagePath;
  final String title;
}

///  Список для онбординга. Зашиваем в приложение, поэтому просто тут
const onboardingList = <OnboardingItem>[
  OnboardingItem(title: onboardingTitle1, imagePath: onboardingImage1),
  OnboardingItem(title: onboardingTitle2, imagePath: onboardingImage2),
  // TODO Вернуть если понадобится экран бонусов и подарков
  // OnboardingItem(title: onboardingTitle3, imagePath: onboardingImage3),
];
