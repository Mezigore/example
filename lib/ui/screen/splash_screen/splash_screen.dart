import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/screen/splash_screen/di/splash_screen_component.dart';
import 'package:uzhindoma/ui/screen/splash_screen/splash_wm.dart';

/// Splash screen
class SplashScreen extends MwwmWidget<SplashScreenComponent> {
  SplashScreen(Object data,{
    Key key,
    WidgetModelBuilder widgetModelBuilder = createSplashScreenWidgetModel,
  }) : super(
          key: key,
          dependenciesBuilder: (context) => SplashScreenComponent(context,data),
          widgetStateBuilder: () => _SplashScreenState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _SplashScreenState extends WidgetState<SplashScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<SplashScreenComponent>(context).component.scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInImage(
              width: 191,
              placeholder: MemoryImage(kTransparentImage),
              image: const AssetImage(splashLogo),
            ),
          ],
        ),
      ),
    );
  }
}
