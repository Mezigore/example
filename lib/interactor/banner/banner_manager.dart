import 'package:pedantic/pedantic.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/banner/banner.dart';
import 'package:uzhindoma/domain/banner/new_banners.dart';
import 'package:uzhindoma/interactor/banner/banner_interactor.dart';

/// Менеджер для работы с баннерами.
/// в будущем будет разделение на
/// баннеры для разных экранов
class BannerManager {
  BannerManager(this._bannerInteractor);

  final BannerInteractor _bannerInteractor;

  /// получаем список баннеров
  final bannerListState = EntityStreamedState<List<Banner>>();

  /// получаем список баннеров
  final newBannersListState = EntityStreamedState<List<NewBanners>>();

  Future<void> init() async {
    await bannerListState.loading();
    await newBannersListState.loading();
    await _getBanners();
    await _getNewBanners();
  }

  Future<void> _getBanners() async {
    final banners = await _bannerInteractor.getBanners();
    await bannerListState.content(banners);
  }

  Future<void> _getNewBanners() async {
    final banners = await _bannerInteractor.getNewBanners();
    await newBannersListState.content(banners);
  }
}
