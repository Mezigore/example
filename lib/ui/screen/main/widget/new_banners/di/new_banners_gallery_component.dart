import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/interactor/banner/banner_manager.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/screen/main/widget/new_banners/new_banners_gallery_wm.dart';

/// [Component] для <NewBannersGallery>
class NewBannersGalleryComponent implements Component {
  NewBannersGalleryComponent(BuildContext context) {
    parent = Injector.of<AppComponent>(context).component;

    bannerManager = parent.bannerManager;

    wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        dialogController,
        parent.scInteractor,
      ),
    );

    navigator = Navigator.of(context);
  }

  AppComponent parent;
  MessageController messageController;
  DialogController dialogController;
  WidgetModelDependencies wmDependencies;
  BannerManager bannerManager;
  NavigatorState navigator;
}

NewBannersGalleryWidgetModel createBannerGalleryWidgetModel(BuildContext context) {
  final component = Injector.of<NewBannersGalleryComponent>(context).component;

  return NewBannersGalleryWidgetModel(
    component.wmDependencies,
    bannerManager: component.bannerManager,
    navigator: component.navigator,
  );
}
