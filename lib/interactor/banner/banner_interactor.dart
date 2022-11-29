import 'package:uzhindoma/domain/banner/banner.dart';
import 'package:uzhindoma/domain/banner/new_banners.dart';
import 'package:uzhindoma/interactor/banner/repository/banner_repository.dart';

/// Интерактор работы с баннер
class BannerInteractor {
  BannerInteractor(this._bannerRepository);

  final BannerRepository _bannerRepository;

  /// Загружает текущую корзину.
  Future<List<Banner>> getBanners() {
    return _bannerRepository.getBanners();
  }
  /// Загружает текущую корзину.
  Future<List<NewBanners>> getNewBanners() {
    return _bannerRepository.getNewBanners();
  }
}
