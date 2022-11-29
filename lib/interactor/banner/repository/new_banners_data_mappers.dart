import 'package:uzhindoma/api/data/banner/banner_data.dart';
import 'package:uzhindoma/api/data/banner/new_banners_data.dart';
import 'package:uzhindoma/domain/banner/banner.dart';
import 'package:uzhindoma/domain/banner/new_banners.dart';

NewBanners mapNewBannersForMain(NewBannersData data) {
  return NewBanners(
    id: data.id,
    name: data.name,
    sort: data.sort,
    image: data.image,
    type: data.type,
    value: data.value,
    size: data.size,
  );
}
