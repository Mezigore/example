import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uzhindoma/api/data/banner/banner_data.dart';
import 'package:uzhindoma/api/data/banner/new_banners_data.dart';
import 'package:uzhindoma/interactor/common/urls.dart';

part 'banner_client.g.dart';

/// Интерфейс API баннера.
@RestApi()
abstract class BannerClient {
  factory BannerClient(Dio dio, {String baseUrl}) = _BannerClient;

  @GET(BannerApiUrl.getBanners)
  Future<List<BannerData>> getBanner();

  @GET(BannerApiUrl.getNewBanners)
  Future<List<NewBannersData>> getNewBanners();
}
