import 'package:uzhindoma/domain/banner/banner.dart';
import 'package:uzhindoma/domain/banner/new_banners.dart';
import 'package:uzhindoma/interactor/banner/repository/banner_repository.dart';

/// Mock репозиторий для работы с баннерами
class BannerRepositoryMock implements BannerRepository {
  @override
  Future<List<Banner>> getBanners() async {
    return <Banner>[];
  }
  @override
  Future<List<NewBanners>> getNewBanners() async {
    return <NewBanners>[];
  }
}
