import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/screen/splash_screen/splash_screen.dart';

/// роут для экрана SplashScreen
class SplashScreenRoute extends MaterialPageRoute<void> {
  SplashScreenRoute(Object data) : super(builder: (ctx) => SplashScreen(data));
}
