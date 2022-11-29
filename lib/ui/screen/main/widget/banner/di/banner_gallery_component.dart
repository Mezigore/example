import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/interactor/banner/banner_manager.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/screen/main/widget/banner/banner_gallery_wm.dart';

/// [Component] для <BannerGallery>
class BannerGalleryComponent implements Component {
  BannerGalleryComponent(BuildContext context) {
    parent = Injector.of<AppComponent>(context).component;

    bannerManager = parent.bannerManager;

    wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        dialogController,
        parent.scInteractor,
      ),
    );
  }

  AppComponent parent;
  MessageController messageController;
  DialogController dialogController;
  WidgetModelDependencies wmDependencies;
  BannerManager bannerManager;
}

BannerGalleryWidgetModel createBannerGalleryWidgetModel(BuildContext context) {
  final component = Injector.of<BannerGalleryComponent>(context).component;

  return BannerGalleryWidgetModel(
    component.wmDependencies,
    bannerManager: component.bannerManager,
  );
}
