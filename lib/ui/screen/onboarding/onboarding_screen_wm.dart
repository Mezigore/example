import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/onboarding/onboarding_item.dart';
import 'package:uzhindoma/interactor/auth/auth_manager.dart';
import 'package:uzhindoma/interactor/common/managers/secure_storage.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/res/animations.dart';

/// [WidgetModel] для <OnboardingScreen>
class OnboardingScreenWidgetModel extends WidgetModel {
  OnboardingScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._authManager,
    this._secureStorage,
  ) : super(dependencies);

  final AuthManager _authManager;
  final SecureStorage _secureStorage;
  final NavigatorState _navigator;
  int _currentPage;

  /// Пропустить онбординг
  final skipAction = Action<void>();

  /// Нажатие
  final tapAction = Action<void>();

  /// Выбранная страница
  final pageState = StreamedState<int>();

  /// Контроллер для [PageView]
  final PageController pageController = PageController();

  /// Список страниц к показу
  final List<OnboardingItem> pageList = onboardingList;

  @override
  void onLoad() {
    super.onLoad();

    _handleNewPage(0);
  }

  @override
  void onBind() {
    super.onBind();

    pageController.addListener(_onPageChange);
    bind<void>(skipAction, (_) => _leaveOnboarding());
    bind<void>(tapAction, (_) => _onTap());
  }

  @override
  void dispose() {
    // с диспоузом уйдут и подписки
    pageController.dispose();

    super.dispose();
  }

  void _onPageChange() {
    final index = pageController.page.round();
    if (index != _currentPage) {
      _handleNewPage(index);
    }
  }

  void _handleNewPage(int page) {
    _currentPage = page;
    pageState.accept(_currentPage);
  }

  void _onTap() {
    if (_currentPage == pageList.length - 1) {
      _leaveOnboarding();
    } else {
      pageController.nextPage(
        duration: baseAnimation,
        curve: Curves.linear,
      );
    }
  }

  Future<void> _leaveOnboarding() async {
    await _secureStorage.saveValue(
      SecureStorage.keyOnboardingComplete,
      true.toString(),
    );

    // считаем что на этом моменте мы точно знаем авторизованы или нет,
    // без подписок и ожиданий
    final isAuth = _authManager.isLoginState.value?.data ?? false;
    _openScreen(isAuth ? AppRouter.root : AppRouter.authScreen);
  }

  void _openScreen(String routeName) {
    _navigator.pushReplacementNamed(routeName);
  }
}
