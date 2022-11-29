import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart' as surf_mwwm;
import 'package:uzhindoma/config/config.dart';
import 'package:uzhindoma/config/env/env.dart';
import 'package:uzhindoma/domain/debug_options.dart';
import 'package:uzhindoma/interactor/common/urls.dart';
import 'package:uzhindoma/interactor/debug/debug_screen_interactor.dart';
import 'package:uzhindoma/ui/screen/debug/di/debug_screen_component.dart';
import 'package:uzhindoma/ui/screen/main/main_screen_route.dart';
import 'package:uzhindoma/util/const.dart';

enum UrlType { test, prod, dev }

/// Билдер для [DebugWidgetModel].
DebugWidgetModel createDebugWidgetModel(BuildContext context) {
  final component = Injector.of<DebugScreenComponent>(context).component;

  return DebugWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.debugScreenInteractor,
    component.rebuildApplication,
  );
}

/// WidgetModel для экрана <Debug>
class DebugWidgetModel extends surf_mwwm.WidgetModel {
  DebugWidgetModel(
      surf_mwwm.WidgetModelDependencies dependencies,
    this.navigator,
    this._debugScreenInteractor,
    this._rebuildApplication,
  ) : super(dependencies);


  final NavigatorState navigator;
  final DebugScreenInteractor _debugScreenInteractor;
  final VoidCallback _rebuildApplication;

  final urlState = surf_mwwm.StreamedState<UrlType>();
  surf_mwwm.TextFieldStreamedState proxyValueState;
  final debugOptionsState = surf_mwwm.StreamedState<DebugOptions>(
    Environment<Config>.instance().config.debugOptions,
  );

  final switchServer = surf_mwwm.Action<UrlType>();
  final showDebugNotification = surf_mwwm.Action<void>();
  final closeScreenAction = surf_mwwm.Action<void>();
  final urlChangeAction = surf_mwwm.Action<UrlType>();

  final proxyChanges = surf_mwwm.TextEditingAction();

  final showPerformanceOverlayChangeAction = surf_mwwm.Action<bool>();
  final debugShowMaterialGridChangeAction = surf_mwwm.Action<bool>();
  final checkerboardRasterCacheImagesChangeAction = surf_mwwm.Action<bool>();
  final checkerboardOffscreenLayersChangeAction = surf_mwwm.Action<bool>();
  final showSemanticsDebuggerChangeAction = surf_mwwm.Action<bool>();
  final debugShowCheckedModeBannerChangeAction = surf_mwwm.Action<bool>();
  final setProxy = surf_mwwm.Action<void>();

  String currentUrl;
  String proxyUrl;

  Config get config => Environment<Config>.instance().config;

  set config(Config newConfig) =>
      Environment<Config>.instance().config = newConfig;

  @override
  void onLoad() {
    super.onLoad();

    currentUrl = config.url;
    proxyUrl = config.proxyUrl;

    if (currentUrl == Url.testUrl) {
      urlState.accept(UrlType.test);
    } else if (currentUrl == Url.prodUrl) {
      urlState.accept(UrlType.prod);
    } else {
      urlState.accept(UrlType.dev);
    }

    if (proxyUrl != null && proxyUrl.isNotEmpty) {
      proxyValueState = surf_mwwm.TextFieldStreamedState(proxyUrl);
      proxyChanges.controller.text = proxyUrl;
    } else {
      proxyValueState = surf_mwwm.TextFieldStreamedState(emptyString);
      proxyChanges.controller.text = emptyString;
    }

    bind<UrlType>(
      switchServer,
          (urlType) {
        Config newConfig;
        switch (urlType) {
          case UrlType.test:
            newConfig = config.copyWith(url: Url.testUrl);
            break;
          case UrlType.prod:
            newConfig = config.copyWith(url: Url.prodUrl);
            break;
          default:
            newConfig = config.copyWith(url: Url.devUrl);
            break;
        }
        _refreshApp(newConfig);
      },
    );

    subscribe<DebugOptions>(
      debugOptionsState.stream,
          (value) {
        config = config.copyWith(debugOptions: value);
      },
    );

    bind<void>(
      showDebugNotification,
          (_) => _debugScreenInteractor.showDebugScreenNotification(),
    );

    bind<void>(
      closeScreenAction,
          (_) {
        showDebugNotification.accept();
        navigator.pop();
      },
    );

    bind(urlChangeAction, urlState.accept);

    bind<bool>(
      showPerformanceOverlayChangeAction,
          (value) => _setDebugOptionState(
        config.debugOptions.copyWith(showPerformanceOverlay: value),
      ),
    );

    bind<bool>(
      debugShowMaterialGridChangeAction,
          (value) => _setDebugOptionState(
        config.debugOptions.copyWith(debugShowMaterialGrid: value),
      ),
    );

    bind<bool>(
      checkerboardRasterCacheImagesChangeAction,
          (value) => _setDebugOptionState(
        config.debugOptions.copyWith(checkerboardRasterCacheImages: value),
      ),
    );

    bind<bool>(
      checkerboardOffscreenLayersChangeAction,
          (value) => _setDebugOptionState(
        config.debugOptions.copyWith(checkerboardOffscreenLayers: value),
      ),
    );

    bind<bool>(
      showSemanticsDebuggerChangeAction,
          (value) => _setDebugOptionState(
        config.debugOptions.copyWith(showSemanticsDebugger: value),
      ),
    );

    bind<bool>(
      debugShowCheckedModeBannerChangeAction,
          (value) => _setDebugOptionState(
        config.debugOptions.copyWith(debugShowCheckedModeBanner: value),
      ),
    );

    bind(proxyChanges, proxyValueState.content);

    bind<void>(
      setProxy,
          (_) => _setProxy(),
    );
  }

  void _refreshApp(Config newConfig) {
    config = newConfig;

    _rebuildApplication();

    navigator.pushAndRemoveUntil(MainScreenRoute(), (_) => false);
  }

  void _setProxy() {
    config = config.copyWith(proxyUrl: proxyValueState.value.data);
    _refreshApp(config);
  }

  void _setDebugOptionState(DebugOptions newOpt) {
    config = config.copyWith(debugOptions: newOpt);
    debugOptionsState.accept(newOpt);
  }
}
