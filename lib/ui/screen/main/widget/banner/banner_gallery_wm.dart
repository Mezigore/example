import 'package:flutter/material.dart' hide Action, Banner;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uzhindoma/domain/banner/banner.dart';
import 'package:uzhindoma/interactor/banner/banner_manager.dart';

/// [WidgetModel] для <BannerGallery>
class BannerGalleryWidgetModel extends WidgetModel {
  BannerGalleryWidgetModel(
    WidgetModelDependencies baseDependencies, {
    @required BannerManager bannerManager,
  })  : assert(bannerManager != null),
        _bannerManager = bannerManager,
        super(baseDependencies);

  final BannerManager _bannerManager;

  /// Открывает ссылку банера
  final openBrowserAction = Action<String>();

  EntityStreamedState<List<Banner>> get bannerListState =>
      _bannerManager.bannerListState;

  @override
  void onBind() {
    super.onBind();
    subscribe(openBrowserAction.stream, _openBrowser);
  }

  Future<void> _openBrowser(String url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    }
  }
}
