import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uni_links/uni_links.dart';
import 'package:uzhindoma/interactor/auth/auth_manager.dart';
import 'package:uzhindoma/interactor/common/managers/secure_storage.dart';
import 'package:uzhindoma/interactor/debug/debug_screen_interactor.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/screen/splash_screen/di/splash_screen_component.dart';

/// Билдер для WelcomeScreenWidgetModel.
SplashScreenWidgetModel createSplashScreenWidgetModel(BuildContext context) {
  final component = Injector.of<SplashScreenComponent>(context).component;

  return SplashScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.debugScreenInteractor,
    component.authManager,
    component.secureStorage,
    component.dataLoc,
  );
}

/// [WidgetModel] для экрана <SplashScreen>
class SplashScreenWidgetModel extends WidgetModel {
  SplashScreenWidgetModel(
      WidgetModelDependencies dependencies,
      this._navigator,
      this._debugScreenInteractor,
      this._authManager,
      this._secureStorage,
      this._dataLoc,
      ) : super(dependencies);

  final NavigatorState _navigator;
  final DebugScreenInteractor _debugScreenInteractor;
  final AuthManager _authManager;
  final SecureStorage _secureStorage;
  final Object _dataLoc;
  String initialLink = '';

  @override
  void onLoad() {
    super.onLoad();
    _loadApp();
  }

  void _loadApp() {
    doFuture<void>(
      initApp(),
          (_) => _completeSplash(_dataLoc as String),
      onError: (_) => _completeSplash(_dataLoc as String),
    );
    subscribe<bool>(
      Stream.value(true).delay(const Duration(seconds: 5)),
          (_) => _debugScreenInteractor.showDebugScreenNotification(),
    );
  }

  Future<void> _completeSplash(String initUri) async {
    final isOnBoardingComplete =
    await _secureStorage.hasValue(SecureStorage.keyOnboardingComplete);

    if (!isOnBoardingComplete) {
      _openScreen(AppRouter.onboarding);
    } else {
      final isAuth = _authManager.isLoginState.value?.data ?? false;
      if(Platform.isIOS){
        if(isAuth && initialLink != ''){
          _openScreen(initialLink);
        }else{
          _openScreen(isAuth ? AppRouter.root : AppRouter.authScreen);
        }
      }else{
        if(isAuth && initUri != '/splash'){
          _openScreen(initUri);
        }else{
          _openScreen(isAuth ? AppRouter.root : AppRouter.authScreen);
        }
      }
    }
  }

  void _openScreen(String routeName) {
    _navigator.pushReplacementNamed(routeName);
  }

  Future<void> initApp() {
    return Future.wait<void>(
      [
        _authManager.init(),
        _secureStorage.init(),
        initUniLinks(),
        Future<void>.delayed(const Duration(seconds: 2)),
      ],
    );
  }

  StreamSubscription _sub;


  Future<void> initUniLinks() async {
    try {
      final initialLinks = await getInitialLink();
      if (initialLinks != null) initialLink = Uri.parse(initialLinks).path;
    } catch (e) {
      log('$e\n$initialLink', name: 'initialLink err:');
    }
    if(Platform.isIOS) {
      _sub = uriLinkStream.listen(
            (link) {
          _navigator.pushNamed(link.path);
        },
      );
    }
  }



}
