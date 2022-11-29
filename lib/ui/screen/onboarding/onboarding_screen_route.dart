import 'package:flutter/material.dart';

// ignore: always_use_package_imports
import 'onboarding_screen.dart';

/// Роут для [OnboardingScreen]
class OnboardingScreenRoute extends MaterialPageRoute<void> {
  OnboardingScreenRoute()
      : super(
          builder: (ctx) => OnboardingScreen(),
          fullscreenDialog: true,
        );
}
