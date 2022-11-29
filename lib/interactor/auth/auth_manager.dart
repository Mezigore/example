import 'package:pedantic/pedantic.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/auth/public_key.dart';
import 'package:uzhindoma/interactor/analytics/analytics_interactor.dart';
import 'package:uzhindoma/interactor/auth/auth_interactor.dart';
import 'package:uzhindoma/interactor/banner/banner_manager.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';
import 'package:uzhindoma/interactor/common/managers/crypt_manager.dart';
import 'package:uzhindoma/interactor/common/managers/uid_manager.dart';
import 'package:uzhindoma/interactor/token/token_storage.dart';

/// Менеджер авторизации.
class AuthManager {
  AuthManager(
    this._authInfoStorage,
    this._authInteractor,
    this._cryptManager,
    this._uidManager,
    this._cartManager,
    this._analyticsInteractor,
    this._bannerManager,
  );

  static const String _privateKey = 'Yk6V2p';

  final AuthInfoStorage _authInfoStorage;
  final AuthInteractor _authInteractor;
  final AnalyticsInteractor _analyticsInteractor;
  final CryptManager _cryptManager;
  final UidManager _uidManager;
  final CartManager _cartManager;
  final BannerManager _bannerManager;

  /// состояние авторизованности
  final isLoginState = EntityStreamedState<bool>();

  /// время окончания блокировки отправки запроса смс
  final requestCodeLockedState = StreamedState<DateTime>();

  PublicKey _key;
  String _hashedUid;

  /// Инициализация менеджера.
  /// По окончании инициализации в [isLoginState] обязательно должно
  /// быть значение, авторизованы ли мы.
  Future<void> init() async {
    await isLoginState.loading();

    final String token = await _authInfoStorage.readToken();
    final String userId = await _authInfoStorage.readUserId();

    if (userId != null) _analyticsInteractor.setUserId(userId);
    _analyticsInteractor.events.trackAppOpen();
    // в случае если валидный токен есть в хранилище он будет
    // использоваться - можно ничего не делать. Иначе проверяем восстановление
    if (token == null) {
      final isAuth = await prolongAuth();

      if (isAuth) {
        await _logIn();
      } else {
        await isLoginState.content(false);
        // сразу готовимся к авторизации
        await _checkIn();
      }
    } else {
      await _logIn();
    }
  }

  /// Запросить смс для авторизации.
  Future<void> sendCode(String phoneNumber) async {
    final publicKey = await _getPublicKey();
    final otp = await _authInteractor.sendCode(
      phoneNumber: phoneNumber,
      publicKey: publicKey,
      hashUid: _hashedUid,
    );

    await requestCodeLockedState.accept(
      DateTime.now().add(
        Duration(seconds: otp.nextOtp),
      ),
    );
  }

  /// Отправка кода для подтверждения логина.
  Future<void> checkCode(String phoneNumber, String code) async {
    final publicKey = await _getPublicKey();
    final tokens = await _authInteractor.checkCode(
      phoneNumber: phoneNumber,
      code: code,
      publicKey: publicKey,
      hashUid: _hashedUid,
    );
    await _authInfoStorage.saveTokens(tokens);
    await _logIn();

    _analyticsInteractor.setUserId(tokens.userId);

    // авторизовались - больше не нужны
    _key = null;
    _hashedUid = null;
  }

  /// Выполняет разлогин текущего пользователя.
  Future<void> logout() async {
    await _authInfoStorage.clearData();
    await isLoginState.content(false);
  }

  /// Продлить авторизацию.
  Future<bool> prolongAuth() async {
    final refreshToken = await _authInfoStorage.readRefreshToken();
    if (refreshToken == null) {
      return false;
    } else {
      try {
        final tokens = await _authInteractor.updateToken(refreshToken);
        await _authInfoStorage.saveTokens(tokens);
        return true;
      } on Exception {
        return false;
      }
    }
  }

  void reportEventAuthSuccess(){
    _analyticsInteractor.events.trackAuthSuccess();
  }

  void reportEventOpenDiscountScreen(){
    _analyticsInteractor.events.trackOpenBonusScreen();
  }

  Future<void> _checkIn() async {
    final uid = await _uidManager.uid;
    _key = await _authInteractor.checkIn(uid);
    _hashedUid = _cryptManager.getHash(
      uid,
      salt: _key.publicKey + _privateKey,
    );
  }

  Future<String> _getPublicKey() async {
    // конечно такая себе реализация перезапроса в случае протухшего
    // ключа, но нас этот кейс сейчас мало интересует - пойдет
    if (_key == null || _key.endTime.isBefore(DateTime.now())) {
      await _checkIn();
    }

    return _key.publicKey;
  }

  Future<void> _logIn() async {
    await isLoginState.content(true);
    unawaited(_bannerManager.init());
    unawaited(_cartManager.init());
  }
}
