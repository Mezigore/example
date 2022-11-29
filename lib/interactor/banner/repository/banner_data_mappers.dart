import 'package:uzhindoma/api/data/banner/banner_data.dart';
import 'package:uzhindoma/domain/banner/banner.dart';

Banner mapBannerForMain(BannerData data) {
  return Banner(
    id: data.id,
    title: data.title,
    imageUrl: data.imageUrl,
    url: data.url,
    description: data.description,
  );
}
