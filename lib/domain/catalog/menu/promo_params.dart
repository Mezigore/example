import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';

/// Параметры промо набора.
/// [countDin] - количество товаров.
/// [countPers] - количество персон.
/// [price] - новая цена.
/// [oldPrice] - старая цена.
/// [idB24]
///
class PromoParams {
  PromoParams({
    @required this.countDin,
    @required this.countPers,
    @required this.price,
    @required this.oldPrice,
    this.idB24,
  })
      : assert(countDin != null),
        assert(countPers != null),
        assert(price != null),
        assert(oldPrice != null);

  PromoParams.copy(PromoParams item, {
    int countDin,
    int countPers,
    int price,
    int oldPrice,
    String idB24,
  })
      : countDin = countDin ?? item.countDin,
        countPers = countPers ?? item.countPers,
        price = price ?? item.price,
        oldPrice = oldPrice ?? item.oldPrice,
        idB24 = idB24 ?? item.idB24;

  final int countDin;
  final int countPers;
  final int price;
  final int oldPrice;
  final String idB24;
}