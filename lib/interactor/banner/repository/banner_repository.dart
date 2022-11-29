import 'package:uzhindoma/api/client/banner/banner_client.dart';
import 'package:uzhindoma/domain/banner/banner.dart';
import 'package:uzhindoma/domain/banner/new_banners.dart';
import 'package:uzhindoma/interactor/banner/repository/banner_data_mappers.dart';

import 'new_banners_data_mappers.dart';

/// Репозиторий работы с баннером
class BannerRepository {
  BannerRepository(this._client);

  final BannerClient _client;

  Future<List<Banner>> getBanners() =>
      _client.getBanner().then((value) => value.map(mapBannerForMain).toList());

  Future<List<NewBanners>> getNewBanners() =>
      _client.getNewBanners().then((value) => value.map(mapNewBannersForMain).toList());
}
