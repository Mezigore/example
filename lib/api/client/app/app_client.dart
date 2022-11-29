
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../interactor/common/urls.dart';
import '../../data/app/app_version_data.dart';

part 'app_client.g.dart';


/// Интерфейс API инфо о приложении.
@RestApi()
abstract class AppClient {
  factory AppClient(Dio dio, {String baseUrl}) = _AppClient;

  @GET(AppsApiUrl.versions)
  Future<AppVersionData> getAppVersion();


}