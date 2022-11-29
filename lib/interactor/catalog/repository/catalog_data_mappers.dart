import 'package:uzhindoma/api/data/catalog/city_item_data.dart';
import 'package:uzhindoma/api/data/catalog/menu/category_item_data.dart';
import 'package:uzhindoma/api/data/catalog/menu/promo_item_data.dart';
import 'package:uzhindoma/api/data/catalog/menu/promo_params_item_data.dart';
import 'package:uzhindoma/api/data/catalog/menu/recommendation_item_data.dart';
import 'package:uzhindoma/api/data/catalog/menu/menu_item_data.dart';
import 'package:uzhindoma/api/data/catalog/menu/menu_label_data.dart';
import 'package:uzhindoma/api/data/catalog/menu/properties_menu_item_data.dart';
import 'package:uzhindoma/api/data/catalog/menu/recommendation_item_data.dart';
import 'package:uzhindoma/api/data/catalog/week_item_data.dart';
import 'package:uzhindoma/domain/catalog/city_item.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/promo_item.dart';
import 'package:uzhindoma/domain/catalog/menu/promo_params.dart';
import 'package:uzhindoma/domain/catalog/menu/recommendation_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_label.dart';
import 'package:uzhindoma/domain/catalog/menu/properties_menu_item.dart';
import 'package:uzhindoma/domain/catalog/menu/recommendation_item.dart';
import 'package:uzhindoma/domain/catalog/week_item.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/util/colors.dart';

/// Маппер [WeekItem] из [WeekItemData]
WeekItem mapWeekItem(WeekItemData data) {
  return WeekItem(
    id: data.id,
    startDate: data.startDate,
    endDate: data.endDate,
    description: data.description,
  );
}

/// Маппер [CityItem] из [CityItemData]
CityItem mapCityItem(CityItemData data) {
  return CityItem(
    id: data.id,
    name: data.name,
  );
}

/// Маппер [CategoryItem] из [CategoryItemData]
CategoryItem mapCategoryItem(CategoryItemData data) {
  return CategoryItem(
    id: data.id,
    code: data.code,
    name: data.name,
    showCategoryName: data.showCategoryName,
    description: data.description,
    iconUrl: data.iconUrl,
    count: data.count,
    products: data.products.map(mapMenuItem).toList(),
    isBigCards: data.isBigCards,
  );
}

/// Маппер [PromoItem] из [PromoItemData]
PromoItem mapPromoItem(PromoItemData data) {
  return PromoItem(
    id: data.id,
    code: data.code,
    name: data.name,
    showCategoryName: data.showCategoryName,
    description: data.description,
    iconUrl: data.iconUrl,
    count: data.count,
    products: data.products.map(mapMenuItem).toList(),
    params: mapPromoParamsItem(data.params),
    appTitle: data.appTitle,
    appDescription: data.appDescription,
  );
}

/// Маппер [RecommendationItem] из [RecommendationItemData]
RecommendationItem mapRecommendationItem(RecommendationItemData data) {
  return RecommendationItem(
    title: data.title,
    products: data.products.map(mapMenuItem).toList(),
  );
}

/// Маппер [MenuItem] из [MenuItemData]
MenuItem mapMenuItem(MenuItemData data) {
  return MenuItem(
    id: data.id,
    name: data.name,
    price: data.price,
    promoPrice: data.promoPrice,
    type: mapMenuItemType(data.type),
    properties: mapPropertiesMenuItem(data.properties),
    detailImg: data.detailImg,
    previewImg: data.previewImg,
    measureUnit: data.measureUnit,
    isAvailable: data.isAvailable,
  );
}

/// Маппер [PromoParams] из [PromoParamsItemData]
PromoParams mapPromoParamsItem(PromoParamsItemData data) {
  return PromoParams(
    price: data.price,
    oldPrice: data.oldPrice,
    countPers: data.countPers,
    countDin: data.countDin,
    idB24: data.idB24,
  );
}

/// Маппер [MenuItemType] из [MenuItemTypeData]
MenuItemType mapMenuItemType(MenuItemTypeData data) {
  switch (data) {
    case MenuItemTypeData.common:
      return MenuItemType.common;
    case MenuItemTypeData.premium:
      return MenuItemType.premium;
    case MenuItemTypeData.extra:
      return MenuItemType.extra;
    default:
      throw EnumArgumentException('Not found MenuItemType for $data');
  }
}

/// Маппер [PropertiesMenuItem] из [PropertiesMenuItemData]
PropertiesMenuItem mapPropertiesMenuItem(PropertiesMenuItemData data) {
  return PropertiesMenuItem(
    labels: data.labels?.map(mapMenuItemLabel)?.toList(),
    mainLabel:
        data.mainLabel != null ? mapMenuItemMainLabel(data.mainLabel) : null,
    cookTime: data.cookTime,
    weight: data.weight,
    ratio: data.ratio != null ? int.parse(data.ratio) : null,
    willDeliver: data.willDeliver,
    youNeed: data.youNeed,
    prepareComment: data.prepareComment,
    bguCal: data.bguCal,
    bguProtein: data.bguProtein,
    bguFat: data.bguFat,
    bguCarb: data.bguCarb,
  );
}

/// Маппер [MenuItemLabel] из [MenuItemLabelData]
MenuItemLabel mapMenuItemLabel(MenuItemLabelData data) {
  const hexPattern = '0x';
  var labelColor = data.labelColor;
  var textColor = data.textColor;

  // считаем что всегда приходят цвета в rgba формате без 0x
  if (labelColor != null) {
    labelColor = '$hexPattern${rgbaToArgb(labelColor)}';
  }

  if (textColor != null) {
    textColor = '$hexPattern${rgbaToArgb(textColor)}';
  }

  return MenuItemLabel(
    data.title,
    labelColor,
    textColor,
  );
}

/// Маппер [MenuItemMainLabel] из [MenuItemMainLabelData]
MenuItemMainLabel mapMenuItemMainLabel(MenuItemMainLabelData data) {
  return MenuItemMainLabel(
    data.title,
    data.imageUrl,
  );
}
