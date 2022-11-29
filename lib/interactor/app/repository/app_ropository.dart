
import '../../../api/client/app/app_client.dart';
import '../../../domain/app/app_version.dart';
import 'app_data_mappers.dart';

class AppRepository {
  AppRepository(this._appClient);

  final AppClient _appClient;

  Future<AppVersion> getAppVersion() async {
    final data = await  _appClient.getAppVersion();
    return mapAppVersion(data);
  }

}