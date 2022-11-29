import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/catalog/menu/promo_item.dart';
import 'package:uzhindoma/interactor/promo/promo_interactor.dart';

/// Менеджер для работы с промо набором
class PromoManager {
  PromoManager(this._promoInteractor);

  final PromoInteractor _promoInteractor;

  /// Стрим с промо набором
  final promoSetState = EntityStreamedState<PromoItem>();

  /// Инициирует процесс загрузки промо набора.
  /// Результат отразится в promoSetState.
  Future<void> loadPromoSet() async {
    await promoSetState.loading(promoSetState.value?.data);

    try {
      final promo = await _promoInteractor.getPromoSet();
      await promoSetState.content(promo);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState.error(e, promoSetState.value?.data);
      await promoSetState.accept(newState);
      rethrow;
    }
  }


  Future<String> addPromoToCart() async {
      return _promoInteractor.addPromoToCart();
  }


}
