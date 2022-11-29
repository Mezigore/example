import 'dart:async';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mad_pay/mad_pay.dart' as pay;
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/api/client/addresses/addresses_client.dart';
import 'package:uzhindoma/api/client/app/app_client.dart';
import 'package:uzhindoma/api/client/banner/banner_client.dart';
import 'package:uzhindoma/api/client/cart/cart_client.dart';
import 'package:uzhindoma/api/client/catalog/catalog_client.dart';
import 'package:uzhindoma/api/client/order/order_client.dart';
import 'package:uzhindoma/api/client/payment/payment_client.dart';
import 'package:uzhindoma/api/client/recipes/recipes_client.dart';
import 'package:uzhindoma/api/client/user/user_client.dart';
import 'package:uzhindoma/config/config.dart';
import 'package:uzhindoma/config/env/env.dart';
import 'package:uzhindoma/interactor/address/address_interactor.dart';
import 'package:uzhindoma/interactor/address/repository/address_repository.dart';
import 'package:uzhindoma/interactor/analytics/analytics.dart';
import 'package:uzhindoma/interactor/analytics/analytics_interactor.dart';
import 'package:uzhindoma/interactor/app/app_interactor.dart';
import 'package:uzhindoma/interactor/app/repository/app_ropository.dart';
import 'package:uzhindoma/interactor/auth/auth_interactor.dart';
import 'package:uzhindoma/interactor/auth/auth_manager.dart';
import 'package:uzhindoma/interactor/auth/repository/auth_repository.dart';
import 'package:uzhindoma/interactor/banner/banner_interactor.dart';
import 'package:uzhindoma/interactor/banner/banner_manager.dart';
import 'package:uzhindoma/interactor/banner/repository/banner_repository.dart';
import 'package:uzhindoma/interactor/cart/cart_interactor.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';
import 'package:uzhindoma/interactor/cart/repository/cart_repository.dart';
import 'package:uzhindoma/interactor/catalog/catalog_interactor.dart';
import 'package:uzhindoma/interactor/catalog/menu_manager.dart';
import 'package:uzhindoma/interactor/catalog/menu_storage.dart';
import 'package:uzhindoma/interactor/catalog/repository/catalog_repository.dart';
import 'package:uzhindoma/interactor/city/city_manager.dart';
import 'package:uzhindoma/interactor/common/managers/crypt_manager.dart';
import 'package:uzhindoma/interactor/common/managers/secure_storage.dart';
import 'package:uzhindoma/interactor/common/managers/uid_manager.dart';
import 'package:uzhindoma/interactor/debug/debug_screen_interactor.dart';
import 'package:uzhindoma/interactor/location/location_manager.dart';
import 'package:uzhindoma/interactor/mocker/banner/banner_repository.dart';
import 'package:uzhindoma/interactor/network/header_builder.dart';
import 'package:uzhindoma/interactor/network/refresh_interceptor.dart';
import 'package:uzhindoma/interactor/network/status_mapper.dart';
import 'package:uzhindoma/interactor/order/no_paper_recipe_storage.dart';
import 'package:uzhindoma/interactor/order/order_interactor.dart';
import 'package:uzhindoma/interactor/order/order_manager.dart';
import 'package:uzhindoma/interactor/order/order_repository/order_repository.dart';
import 'package:uzhindoma/interactor/payment/payment_interactor.dart';
import 'package:uzhindoma/interactor/payment/payment_repository/payment_repository.dart';
import 'package:uzhindoma/interactor/permission/permission_manager.dart';
import 'package:uzhindoma/interactor/promo/promo_interactor.dart';
import 'package:uzhindoma/interactor/promo/promo_manager.dart';
import 'package:uzhindoma/interactor/recipes/recipes_interactor.dart';
import 'package:uzhindoma/interactor/recipes/recipes_manager.dart';
import 'package:uzhindoma/interactor/recipes/repository/recipes_repository.dart';
import 'package:uzhindoma/interactor/session/session_changed_interactor.dart';
import 'package:uzhindoma/interactor/token/token_storage.dart';
import 'package:uzhindoma/interactor/user/repository/user_repository.dart';
import 'package:uzhindoma/interactor/user/user_interactor.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/util/sp_helper.dart';

import '../../../interactor/app/app_manager.dart';

/// Component per app
class AppComponent implements Component {
  AppComponent(BuildContext context) {
    context.toString();
    rebuildDependencies();
  }

  StreamSubscription<EntityState<bool>> _authChangeSubscription;

  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();

  final pay.MadPay _pay = pay.MadPay(environment: pay.Environment.production);

  AppRepository _appRepository;
  CatalogRepository _catalogRepository;
  CartRepository _cartRepository;
  AuthRepository _authRepository;
  BannerRepository _bannerRepository;
  UserRepository _userRepository;
  AddressRepository _addressRepository;
  PaymentRepository _paymentRepository;
  OrderRepository _orderRepository;
  RecipesRepository _recipesRepository;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final navigator = GlobalKey<NavigatorState>();

  WidgetModelDependencies wmDependencies;
  MaterialMessageController messageController;
  DefaultDialogController dialogController;
  ErrorHandler errorHandler;
  PreferencesHelper preferencesHelper = PreferencesHelper();
  AuthInfoStorage authStorage;
  MenuStorage menuStorage;
  NoPaperRecipeStorage noPaperStorage;
  Dio http;

  AnalyticsInteractor analyticsInteractor;
  SessionChangedInteractor scInteractor;
  DebugScreenInteractor debugScreenInteractor;
  AppInteractor appInteractor;
  CatalogInteractor catalogInteractor;
  CartInteractor cartInteractor;
  AuthInteractor authInteractor;
  BannerInteractor bannerInteractor;
  UserInteractor userInteractor;
  AddressInteractor addressInteractor;
  PaymentInteractor paymentInteractor;
  OrderInteractor orderInteractor;
  RecipesInteractor recipesInteractor;
  PromoInteractor promoInteractor;

  CityManager cityManager;
  AppManager appManager;
  CartManager cartManager;
  OrderManager orderManager;
  AuthManager authManager;
  UserManager userManager;
  CryptManager cryptManager;
  UidManager uidManager;
  SecureStorage secureStorage;
  BannerManager bannerManager;
  PermissionManager permissionManager;
  LocationManager locationManager;
  MenuManager menuManager;
  RecipesManager recipesManager;
  PromoManager promoManager;

  void rebuildDependencies() {
    _initDependencies();
  }

  void _initDependencies() {
    messageController = MaterialMessageController(scaffoldKey);
    dialogController = DefaultDialogController(scaffoldKey);
    uidManager = UidManager();
    cryptManager = CryptManager();
    menuStorage = MenuStorage(preferencesHelper);
    noPaperStorage = NoPaperRecipeStorage(preferencesHelper);
    secureStorage = SecureStorage(_flutterSecureStorage, preferencesHelper);
    authStorage = AuthInfoStorage(secureStorage);
    http = _initHttp(authStorage);

    permissionManager = PermissionManager();
    locationManager = LocationManager(permissionManager);

    final isMocked =
        Environment<Config>.instance().config.debugOptions.debugUseMocker;
    _bannerRepository = isMocked
        ? BannerRepositoryMock()
        : BannerRepository(BannerClient(http));
    _appRepository = AppRepository(AppClient(http));
    _catalogRepository = CatalogRepository(CatalogClient(http));
    _cartRepository = CartRepository(CartClient(http));
    _paymentRepository = PaymentRepository(PaymentClient(http));
    _userRepository = UserRepository(UserClient(http));
    _addressRepository = AddressRepository(AddressesClient(http));
    _paymentRepository = PaymentRepository(PaymentClient(http));
    _authRepository = AuthRepository(http);
    _orderRepository = OrderRepository(OrderClient(http));
    _recipesRepository = RecipesRepository(RecipesClient(http));

    analyticsInteractor = AnalyticsInteractor(Analytics());
    orderInteractor = OrderInteractor(_orderRepository);
    scInteractor = SessionChangedInteractor(authStorage);
    debugScreenInteractor = DebugScreenInteractor();
    appInteractor = AppInteractor(_appRepository);
    catalogInteractor = CatalogInteractor(_catalogRepository);
    cartInteractor = CartInteractor(_cartRepository);
    authInteractor = AuthInteractor(_authRepository);
    bannerInteractor = BannerInteractor(_bannerRepository);
    userInteractor = UserInteractor(_userRepository);
    addressInteractor = AddressInteractor(_addressRepository);
    paymentInteractor = PaymentInteractor(_paymentRepository);
    recipesInteractor = RecipesInteractor(_recipesRepository);
    bannerManager = BannerManager(bannerInteractor)/*..init()*/;
    promoInteractor = PromoInteractor(_catalogRepository, _cartRepository);
    errorHandler = StandardErrorHandler(
      messageController,
      DefaultDialogController(scaffoldKey),
      scInteractor,
    );


    cartManager = CartManager(authStorage,catalogInteractor,cartInteractor, errorHandler, noPaperStorage);
    recipesManager = RecipesManager(recipesInteractor);
    promoManager = PromoManager(promoInteractor);
    authManager = AuthManager(
      authStorage,
      authInteractor,
      cryptManager,
      uidManager,
      cartManager,
      analyticsInteractor,
      bannerManager,
    );
    _initSensitiveToUserManagers();
    // TODO инициализация не должна быть тут ===========================

    cityManager = CityManager(catalogInteractor, locationManager)..init();
    menuManager = MenuManager(
      catalogInteractor,
      cityManager,
      menuStorage,
    )..init();
    appManager = AppManager(appInteractor)..init();
    // TODO инициализация не должна быть тут ===========================

    _authChangeSubscription = authManager.isLoginState.stream.listen(
      (state) {
        if (state.hasError || state.data == null || !state.data) {
          _initSensitiveToUserManagers();
        }
      },
    );

    http.interceptors.addAll([
      RefreshTokenInterceptor(authManager),
    ]);
    wmDependencies = WidgetModelDependencies(
      errorHandler: errorHandler,
    );
  }

  void _initSensitiveToUserManagers() {
    // инициализировать то что хранит данные о пользователе нужно здесь
    // было бы наверное правильно сюда и корзину утащить,
    // но у нас ее уже инициализирует менеджер авторизации
    userManager = UserManager(
      userInteractor,
      addressInteractor,
      paymentInteractor,
      authStorage,
    );
    orderManager = OrderManager(
      orderInteractor,
      cartManager,
      menuManager,
      _pay,
      analyticsInteractor,
    );
  }

  Dio _initHttp(AuthInfoStorage authStorage) {
    final config = Environment<Config>.instance().config;
    final proxyUrl = config.proxyUrl;
    final dio = Dio();

    const timeout = Duration(seconds: 30);

    dio.options
      ..baseUrl = config.url
      ..connectTimeout = timeout.inMilliseconds
      ..receiveTimeout = timeout.inMilliseconds
      ..sendTimeout = timeout.inMilliseconds;

    if (proxyUrl != null && proxyUrl.isNotEmpty) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) => 'PROXY $proxyUrl';
        // ignore: cascade_invocations
        client.badCertificateCallback = (cert, host, port) => true;
      };
    }

    final headerBuilder = DefaultHeaderBuilder(authStorage);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final customHeaders =
              headerBuilder.buildDynamicHeader(options.uri.origin);
          options.headers.addAll(customHeaders);
          return handler.next(options);
        },
      ),
    );

    final statusMapper = DefaultStatusMapper();

    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) async {
          statusMapper.checkStatus(response);
          handler.next(response);
        },
      ),
    );
    if (!Environment<Config>.instance().isRelease) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
    return dio;
  }

  // Сейчас не используется, потому что этот компонент живет весь Runtime
  // в случае если это изменится, должен быть вызван
  Future<void> dispose() async {
    await _authChangeSubscription.cancel();
    _authChangeSubscription = null;
  }
}
