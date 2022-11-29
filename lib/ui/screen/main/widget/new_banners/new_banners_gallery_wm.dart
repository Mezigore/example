import 'dart:developer';

import 'package:flutter/material.dart' hide Action, Banner;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uzhindoma/domain/banner/new_banners.dart';
import 'package:uzhindoma/interactor/banner/banner_manager.dart';
import 'package:uzhindoma/domain/banner/banner.dart';
import 'package:clipboard/clipboard.dart';

/// [WidgetModel] для <BannerGallery>
class NewBannersGalleryWidgetModel extends WidgetModel {
  NewBannersGalleryWidgetModel(
      WidgetModelDependencies baseDependencies, {
        @required BannerManager bannerManager,
        @required NavigatorState navigator,
      })  : assert(bannerManager != null),
        _bannerManager = bannerManager,
        _navigator = navigator,
        super(baseDependencies);

  final BannerManager _bannerManager;
  final NavigatorState _navigator;

  /// Открывает ссылку банера
  final openBrowserAction = Action<String>();

  /// Открывает окно приложения
  final openScreenAction = Action<String>();


  EntityStreamedState<List<NewBanners>> get newBannersListState =>
      _bannerManager.newBannersListState;

  @override
  void onBind() {
    super.onBind();
    subscribe(openBrowserAction.stream, _openBrowser);
    subscribe(openScreenAction.stream, _openScreen);
  }



  ///Составляем список баннеров для правильной работы CarouselSlider
  List<List<NewBanners>> parseBanners (List<NewBanners> newBanners){
    final List<List<NewBanners>> listBanners = [];
    for(int i = 0; i<newBanners.length; i){
      ///Проверяем размер баннера, если баннер большой
      ///добавляем 2 элемента
      if(newBanners[i].size == 'big'){
        listBanners.add([newBanners[i], newBanners[i+1]]);
        ///Проверяем, чтобы не уйти за границы списка
        if(i+2<=newBanners.length){
          i = i + 2;
        }else{
          i = i + 1;
        }
      }else{
        ///Проверяем можем ли мы собрать последний элемент из 3х баннеров
        if(newBanners.length - i < 3 && i + 2 <= newBanners.length){
          listBanners.add([newBanners[i], newBanners[i+1]]);
        }else if(newBanners.length - i < 2 && i + 1 <= newBanners.length){
          listBanners.add([newBanners[i]]);
        }else{
          listBanners.add([newBanners[i], newBanners[i+1], newBanners[i+2]]);
        }
        ///Проверяем, чтобы не уйти за границы списка
        if(i+3<=newBanners.length){
          i = i + 3;
        }else if(i+2<=newBanners.length){
          i = i + 2;
        }else{
          i = i + 1;
        }
      }
    }
    return listBanners;
  }


  Future<void> _openBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    if (url != null && await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _openScreen(String routeName) {
    _navigator.pushNamed(routeName);
  }
}
