

import '../../../api/data/app/app_version_data.dart';
import '../../../domain/app/app_version.dart';


/// Маппер [AppVersion] из [AppVersionData]
AppVersion mapAppVersion (AppVersionData data){
  return AppVersion(
    appStore: data.appStore,
    playMarket: data.playMarket,
  );
}