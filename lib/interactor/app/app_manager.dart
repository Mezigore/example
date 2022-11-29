import 'dart:async';

import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/interactor/app/app_interactor.dart';

import '../../domain/app/app_version.dart';

///Менеджер для проверки информации о приложении
class AppManager{
  AppManager(this._appInteractor);

  final AppInteractor _appInteractor;



  /// Версия приложения
  final versionState = EntityStreamedState<AppVersion>();


  /// Текущая версия приложения
  AppVersion get currentAppVersion => versionState.value?.data;

  Future<void> init() async {
    await versionState.loading();
    await _getVersion();
  }

  Future<void> _getVersion()async {
    final version = await _appInteractor.getAppVersion();
    await versionState.content(version);
  }

}