import 'dart:async';
import 'dart:developer';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/material/bottom_sheet.dart';
import 'package:flutter/widgets.dart' hide Action, MenuItem;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/domain/catalog/menu/promo_item.dart';
import 'package:uzhindoma/domain/core.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';
import 'package:uzhindoma/interactor/promo/promo_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/common/reload/reload_mixin.dart';
import 'package:uzhindoma/ui/screen/promo/widgets/promo_bottom_sheet.dart';

import '../../../interactor/analytics/analytics_interactor.dart';

/// [WidgetModel] для <PromoScreen>
class PromoScreenWidgetModel extends WidgetModel with ReloadMixin {
  PromoScreenWidgetModel(
      WidgetModelDependencies dependencies,
      this._navigator,
      this._promoManager,
      this._cartManager,
      this._analyticsInteractor,
      ) : super(dependencies);

  //ignore: unused_field
  final NavigatorState _navigator;
  final PromoManager _promoManager;
  final CartManager _cartManager;
  final AnalyticsInteractor _analyticsInteractor;

  /// Нажатие на карточку
  final selectCardAction = Action<MenuItem>();
  /// Нажатие на кнопку добавления в корзину
  final addPromoToCartAction = Action<void>();


  final promoSetState = EntityStreamedState<PromoItem>();

  @override
  void onLoad() {
    super.onLoad();
    AppMetrica.reportEvent('promo_view');
    _analyticsInteractor.events.trackOpenPromoScreen();
    subscribe<EntityState<PromoItem>>(
        _promoManager.promoSetState.stream, (entity) {
      promoSetState.accept(
        EntityState(
          data: entity.data,
          isLoading: entity.isLoading,
          hasError: entity.hasError,
        ),
      );
    });
    if (promoSetState.value?.data == null) reloadData();
  }

  @override
  void onBind() {
    super.onBind();
    subscribe<MenuItem>(selectCardAction.stream, _openDetailsScreen);
    subscribe<void>(addPromoToCartAction.stream, (_) => _addPromoToCart());
  }

  @override
  void reloadData() {
    doFutureHandleError<void>(
      _promoManager.loadPromoSet(),
                (_) => reloadState.accept(SwipeRefreshState.hidden),
            onError: (_) => reloadState.accept(SwipeRefreshState.hidden),
          );
  }

  void _openDetailsScreen(MenuItem menuItem) {
    _navigator.pushNamed(
      AppRouter.menuItemForYouDetailsScreen,
      arguments: Pair<List<CategoryItem>, MenuItem>(
        [
          CategoryItem(
            id: promoSetState.value.data.id,
            code: promoSetState.value.data.code,
            name: 'Промо-набор',
            showCategoryName: true,
            products: promoSetState.value.data.products,
            count: promoSetState.value.data.products.length,
          ),
        ],
        menuItem,
      ),
    );
  }

  Future<void> _addPromoToCart() async {
    try {
    final promoname = await _promoManager.addPromoToCart();
    Future.delayed(const Duration(milliseconds: 1000),(){
      _cartManager.updateCart(promo:promoname);
      });
    Future.delayed(const Duration(milliseconds: 1500),(){
      _navigator.pushNamed(AppRouter.cartScreen);
    });
    } on DioError catch (e) {
      log('${e.response.data}', name: 'addPromo ERR');
      await showModalBottomSheet<void>(
        context: _navigator.context,
        isScrollControlled: true,
        builder: (ctx) {
          return const PromoErrBottomSheet();
        },
      );
    } on Exception catch (e) {
      log(e.toString(), name: '_addPromoToCart');
      // rethrow;
    }
  }


}
