import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/config/config.dart';
import 'package:uzhindoma/config/env/env.dart';
import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/domain/core.dart';
import 'package:uzhindoma/domain/debug_options.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/domain/order/order_change_enum.dart';
import 'package:uzhindoma/domain/order/order_from_history.dart';
import 'package:uzhindoma/domain/phone_number.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/interactor/analytics/base/analytics_observer.dart';
import 'package:uzhindoma/ui/app/app_wm.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/common/layout/status_bar_widget.dart';
import 'package:uzhindoma/ui/res/locale.dart';
import 'package:uzhindoma/ui/res/styles.dart';
import 'package:uzhindoma/ui/screen/about/about_screen_route.dart';
import 'package:uzhindoma/ui/screen/auth/auth_route.dart';
import 'package:uzhindoma/ui/screen/cart/cart_route.dart';
import 'package:uzhindoma/ui/screen/cart/screens/cart_item_info/cart_item_info_screen_route.dart';
import 'package:uzhindoma/ui/screen/confirmation/confirmation_route.dart';
import 'package:uzhindoma/ui/screen/confirmation_replacement_phone_number/confirmation_replacement_phone_number_route.dart';
import 'package:uzhindoma/ui/screen/create_address/create_address_screen_route.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/create_address/create_address_screen_route.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_address/select_address_screen_route.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_delivery_date/select_delivery_date_screen_route.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_payment_screen/select_payment_screen_route.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/thanks/thanks_screen_route.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/user_info_screen/user_info_screen_route.dart';
import 'package:uzhindoma/ui/screen/debug/debug_route.dart';
import 'package:uzhindoma/ui/screen/discount/discount_screen_route.dart';
import 'package:uzhindoma/ui/screen/main/main_screen_route.dart';
import 'package:uzhindoma/ui/screen/menu_item_details/menu_item_details_route.dart';
import 'package:uzhindoma/ui/screen/menu_item_details/menu_item_for_you/menu_item_for_you_details_route.dart';
import 'package:uzhindoma/ui/screen/onboarding/onboarding_screen_route.dart';
import 'package:uzhindoma/ui/screen/orders_history/orders_history_screen_route.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/change_order/change_order_screen_route.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/new_order_info/new_order_info_screen_route.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/rate_order/rate_order_screen_route.dart';
import 'package:uzhindoma/ui/screen/profile/profile_route.dart';
import 'package:uzhindoma/ui/screen/promo/promo_screen_route.dart';
import 'package:uzhindoma/ui/screen/recipes/recipes_screen_route.dart';
import 'package:uzhindoma/ui/screen/recipes/screens/recipe_detail/recipe_details_screen_route.dart';
import 'package:uzhindoma/ui/screen/replacement_phone_number/replacement_phone_number_route.dart';
import 'package:uzhindoma/ui/screen/splash_screen/splash_route.dart';
import 'package:uzhindoma/ui/screen/update_address/update_address_screen_route.dart';
import 'package:uzhindoma/ui/screen/webview_screen/web_view_screen_route.dart';
import 'package:uzhindoma/util/error_widget.dart' as error_widget;

/// Список маршрутов приложения
class AppRouter {
  static const String root = '/';
  static const String debug = '/debug';
  static const String splashScreen = '/splash';
  static const String onboarding = '/onboarding';
  static const String menuItemDetailsScreen = '/menuItemDetailsScreen';
  static const String menuItemForYouDetailsScreen =
      '/menuItemForYouDetailsScreen';
  static const String authScreen = '/auth';
  static const String aboutScreen = '/about';
  static const String confirmation = '/confirmation';
  static const String profile = '/profile';
  static const String addAddressScreen = '/addAddress';
  static const String updateAddressScreen = '/updateAddress';
  static const String cartScreen = '/cart';
  static const String cartItemInfoScreen = '/cartItemInfo';
  static const String ordersScreen = '/orders';
  static const String discountScreen = '/discount';
  static const String rateOrderScreen = '/rateOrderScreen';
  static const String webViewScreen = '/vebView';
  static const String newOrderInfo = '/newOrderInfo';
  static const String createOrderUserInfo = '/createOrderUserInfo';
  static const String createOrderCreateAddress = '/createOrderCreateAddress';
  static const String createOrderSelectAddress = '/createOrderSelectAddress';
  static const String createOrderSelectPayment = '/createOrderSelectPayment';
  static const String createOrderTYP = '/createOrderTYP';
  static const String recipesScreen = '/recipesScreen';
  static const String recipeDetail = '/recipeDetail';
  static const String promoScreen = '/promo';
  static const String createOrderSelectDeliveryDate =
      '/createOrderSelectDeliveryDate';
  static const String changeOrder = '/changeOrder';
  static const String replacementPhoneNumber =
      '/confirmationReplacementPhoneNumber';
  static const String confirmationReplacementPhoneNumberScreen =
      '/confirmationReplacementPhoneNumberScreen';

  static final Map<String, Route Function(Object)> routes = {
    AppRouter.root: (data) => MainScreenRoute(),
    AppRouter.debug: (data) => DebugScreenRoute(),
    AppRouter.aboutScreen: (data) => AboutScreenRoute(),
    AppRouter.splashScreen: (data) => SplashScreenRoute(data),
    AppRouter.onboarding: (data) => OnboardingScreenRoute(),
    AppRouter.authScreen: (data) => AuthRoute(),
    AppRouter.webViewScreen: (data) {
      if (data is String) {
        return WebViewScreenRoute(data);
      } else {
        final pair = data as Pair<String, bool>;
        return WebViewScreenRoute(pair.first, needAppbar: pair.second);
      }
    },
    AppRouter.addAddressScreen: (data) => CreateAddressScreenRoute(),
    AppRouter.createOrderUserInfo: (data) => UserInfoScreenRoute(),
    AppRouter.recipesScreen: (data) => RecipesScreenRoute(),
    AppRouter.recipeDetail: (data) => RecipeDetailsScreenRoute(
          (data as Pair<Recipe, bool>).first,
          isArchived: (data as Pair<Recipe, bool>).second,
        ),
    AppRouter.createOrderSelectAddress: (data) => SelectAddressScreenRoute(
          isForSelf: data as bool,
        ),
    AppRouter.createOrderSelectPayment: (data) => SelectPaymentScreenRoute(),
    AppRouter.createOrderTYP: (data) => ThanksScreenRoute(
      isPayed: (data as Pair<bool, int>).first,
      ordersCount: (data as Pair<bool, int>).second,
    ),
    AppRouter.createOrderSelectDeliveryDate: (data) =>
        SelectDeliveryDateScreenRoute(),
    AppRouter.createOrderCreateAddress: (data) =>
        CreateOrderAddressScreenRoute(canGoBack: data as bool),
    AppRouter.cartItemInfoScreen: (data) => CartItemInfoScreenRoute(
          data as MenuItem,
        ),
    AppRouter.updateAddressScreen: (data) => UpdateAddressScreenRoute(
        (data as Pair<int, NewAddress>).first,
        (data as Pair<int, NewAddress>).second),
    AppRouter.profile: (data) => ProfileRoute(),
    AppRouter.cartScreen: (data) => CartRoute(),
    AppRouter.ordersScreen: (data) => OrdersHistoryScreenRoute(),
    AppRouter.promoScreen: (data) => PromoScreenRoute(),
    AppRouter.discountScreen: (data) => DiscountScreenRoute(),
    AppRouter.rateOrderScreen: (data) => RateOrderScreenRoute(
          data as OrderFromHistory,
        ),
    AppRouter.newOrderInfo: (data) => NewOrderInfoScreenRoute(
          data as NewOrder,
        ),
    AppRouter.changeOrder: (data) => ChangeOrderScreenRoute(
          (data as Pair<OrderChanges, NewOrder>).first,
          (data as Pair<OrderChanges, NewOrder>).second,
        ),
    AppRouter.confirmationReplacementPhoneNumberScreen: (data) {
      assert(data != null, data is PhoneNumber);
      return ConfirmationReplacementPhoneNumberRoute(data as PhoneNumber);
    },
    AppRouter.confirmation: (data) {
      assert(data != null, data is PhoneNumber);
      return ConfirmationRoute(phoneNumber: data as PhoneNumber);
    },
    AppRouter.menuItemDetailsScreen: (data) {
      assert(data != null && data is Pair<List<CategoryItem>, MenuItem>);
      return MenuItemDetailsRoute(
        listCategoryItem: (data as Pair<List<CategoryItem>, MenuItem>).first,
        menuItem: (data as Pair<List<CategoryItem>, MenuItem>).second,
      );
    },
    AppRouter.menuItemForYouDetailsScreen: (data) {
      assert(data != null && data is Pair<List<CategoryItem>, MenuItem>);
      return MenuItemForYouDetailsRoute(
        listCategoryItem: (data as Pair<List<CategoryItem>, MenuItem>).first,
        menuItem: (data as Pair<List<CategoryItem>, MenuItem>).second,
      );
    },
    AppRouter.replacementPhoneNumber: (data) => ReplacementPhoneNumberRoute(),
  };
}

/// Виджет приложения
class App extends MwwmWidget<AppComponent> {
  App({
    Key key,
    WidgetModelBuilder widgetModelBuilder = createAppWidgetModel,
  }) : super(
          key: key,
          dependenciesBuilder: (context) => AppComponent(context),
          widgetStateBuilder: () => _AppState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _AppState extends WidgetState<AppWidgetModel> {
  @override
  void initState() {
    super.initState();
    Environment<Config>.instance().addListener(_setStateOnChangeConfig);
  }

  @override
  void dispose() {
    Environment<Config>.instance().removeListener(_setStateOnChangeConfig);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Injector.of<AppComponent>(context).component.navigator,
      builder: (context, widget) {
        ErrorWidget.builder = (flutterErrorDetails) {
          return error_widget.ErrorWidget(
            context: context,
            error: flutterErrorDetails,
            backgroundColor: Colors.white,
            textColor: Colors.black,
          );
        };
        return DarkIconStatusBarWidget(child: widget);
      },
      supportedLocales: const [
        rusLocale,
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: themeData,
      initialRoute: AppRouter.splashScreen,
      showPerformanceOverlay: getDebugConfig().showPerformanceOverlay,
      debugShowMaterialGrid: getDebugConfig().debugShowMaterialGrid,
      checkerboardRasterCacheImages:
          getDebugConfig().checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: getDebugConfig().checkerboardOffscreenLayers,
      showSemanticsDebugger: getDebugConfig().showSemanticsDebugger,
      debugShowCheckedModeBanner: getDebugConfig().debugShowCheckedModeBanner,
      navigatorObservers: [
        AnalyticsNavigationObserver(),
      ],
      onGenerateRoute: (routeSettings) {
        return AppRouter.routes[routeSettings.name](routeSettings.arguments);
      },
      onGenerateInitialRoutes: (name) {
        return [
          // AppRouter.routes[name](null),
          AppRouter.routes[AppRouter.splashScreen](name),
        ];
      },
    );
  }

  void _setStateOnChangeConfig() {
    setState(() {});
  }

  DebugOptions getDebugConfig() {
    return Environment<Config>.instance().config.debugOptions;
  }
}
