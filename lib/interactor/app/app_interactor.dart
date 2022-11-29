

import 'package:uzhindoma/interactor/app/repository/app_ropository.dart';

import '../../domain/app/app_version.dart';

class AppInteractor{
  AppInteractor(this._appRepository);

  final AppRepository _appRepository;

  Future<AppVersion> getAppVersion() {
    return _appRepository.getAppVersion();
  }
}