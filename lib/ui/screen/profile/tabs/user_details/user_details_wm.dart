import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_mwwm/surf_mwwm.dart' as surf_mwwm;
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/user/favourite_item.dart';
import 'package:uzhindoma/domain/user/gender_info.dart';
import 'package:uzhindoma/domain/user/update_profile.dart';
import 'package:uzhindoma/domain/user/user_info.dart';
import 'package:uzhindoma/interactor/auth/auth_manager.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/common/reload/reload_mixin.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/screen/profile/profile_screen.dart';
import 'package:uzhindoma/ui/screen/profile/tabs/user_details/user_details_widget.dart';
import 'package:uzhindoma/util/const.dart';
import 'package:uzhindoma/util/date_formatter.dart';

const idFavoriteDishes = 'idFavoriteDishes';
const idTopWidget = 'idTopWidget';

/// [WidgetModel] for [UserDetailsWidget]
class UserDetailsWidgetModel extends WidgetModel with ReloadMixin {
  UserDetailsWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._userManager,
    this.parentScaffoldKey,
    this._messageController,
    this._bottomSheetDatePickerDialogController,
    this._dialogController2,
    this._authManager,
  ) : super(dependencies);

  final BottomSheetDatePickerDialogController
      _bottomSheetDatePickerDialogController;

  final MaterialMessageController _messageController;

  final formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> parentScaffoldKey;

  final ScrollController scrollController = ScrollController();

  final DefaultDialogController _dialogController2;

  final NavigatorState _navigator;

  final UserManager _userManager;

  final AuthManager _authManager;

  final List<FocusNode> _fieldsWithValidateError = [];

  /// Факус на поле Любимые блюда
  final FocusNode focusNode = FocusNode();
  final nameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final emailFocus = FocusNode();

  /// Контроллеры для полей TextField
  final nameController = surf_mwwm.TextEditingAction();
  final lastNameController = surf_mwwm.TextEditingAction();
  final emailController = surf_mwwm.TextEditingAction();
  final phoneController = surf_mwwm.TextEditingAction();
  final birthdayController = surf_mwwm.TextEditingAction();
  final favoriteDishesController = surf_mwwm.TextEditingAction();

  /// Переход на экран редиктирования номера
  final onChangePhoneAction = surf_mwwm.Action<void>();

  /// Изменить дату рождения
  final onChangeBirthdayAction = surf_mwwm.Action<void>();

  /// Выбранный пол в парофил
  final onSelectGenderAction = surf_mwwm.Action<GenderInfo>();

  /// Сохранить изменения
  final onSaveAction = surf_mwwm.Action<void>();

  /// Удалить аккаунт
  final onDeleteAccount = surf_mwwm.Action<void>();

  /// Добавить поле для фокуса
  final onAddFocusWithError = surf_mwwm.Action<FocusNode>();

  /// Убрать поле из списка
  final onRemoveFocusWithError = surf_mwwm.Action<FocusNode>();

  /// Открыта ли клавиатура
  final isOpenKeyboardState = surf_mwwm.StreamedState<bool>(false);

  /// Выбранный пол
  final genderState = surf_mwwm.StreamedState<GenderInfo>();

  /// Фокус на поле Любимые блюда
  final heightFavoriteState = surf_mwwm.StreamedState<double>(0.0);

  /// Кнопка сохранения изменений
  final acceptButtonState = surf_mwwm.StreamedState<bool>();

  /// Показать кнопку сохренния изменений
  final _showAcceptButtonState = surf_mwwm.StreamedState<bool>(true);

  /// Заблокировать изменения дня рождения
  final lockBirthdayState = surf_mwwm.StreamedState<bool>(false);

  /// Любимые блюда
  final favouriteItemsState = surf_mwwm.StreamedState<List<FavouriteItem>>();

  /// Удалить Любимое блюдо
  final onRemoveFavouriteItem = surf_mwwm.Action<FavouriteItem>();

  /// показывать ли кнопку сохранения
  CombineLatestStream<dynamic, bool> _isShowAcceptButtonState;

  surf_mwwm.EntityStreamedState<UserInfo> get userState =>
      _userManager.userState;

  /// Изменения всех полей профиля
  CombineLatestStream<dynamic, bool> _dataChangeInUserInfoStream;

  /// Инфомация а пользоввателе
  UserInfo _userInfo;

  /// Менеджер положения виджета
  RenderParametersManager renderManager = RenderParametersManager<dynamic>();

  /// Разница в положении двух виджетов
  ComparisonDiff diff;

  /// Место занимаемое клавиатурой
  final bottomSizeState = surf_mwwm.StreamedState<double>();

  /// Размеры отрендеренного виджета
  RenderData renderSize;

  /// Поиск любимых блюд
  final searchFavoriteState =
      surf_mwwm.StreamedState<surf_mwwm.EntityState<List<FavouriteItem>>>();

  /// Выбрать любимое блюдо
  final onSelectFavoriteItem = surf_mwwm.Action<FavouriteItem>();

  final _selectedBirthdayAction = surf_mwwm.Action<DateTime>();

  @override
  void onLoad() {
    super.onLoad();
    init();
  }

  @override
  void reloadData() {
    doFutureHandleError<void>(
      _userManager.loadUserInfo(),
      (_) => reloadState.accept(SwipeRefreshState.hidden),
      onError: (_) => reloadState.accept(SwipeRefreshState.hidden),
    );
  }

  Future<void> init() async {
    focusNode.addListener(_listenFocus);

    /// Подписываемся на все изменния в профиле
    _dataChangeInUserInfoStream = CombineLatestStream.combine5<String, String,
        String, String, GenderInfo, bool>(
      nameController.stream,
      lastNameController.stream,
      emailController.stream,
      birthdayController.stream,
      genderState.stream,
      _hasChangesInProfile,
    );

    /// Если есть изменения в профиле, клавиатура не видна,
    /// не состояние загрузки виджета, показываем кнопку
    _isShowAcceptButtonState = CombineLatestStream.combine4<bool, bool,
        surf_mwwm.EntityState, bool, bool>(
      _dataChangeInUserInfoStream,
      isOpenKeyboardState.stream,
      userState.stream,
      _showAcceptButtonState.stream,
      (
        isDataChange,
        isOpenKeyboard,
        entityState,
        isShowButton,
      ) {
        return isDataChange &&
            !isOpenKeyboard &&
            !entityState.isLoading &&
            isShowButton;
      },
    );
  }

  bool _hasChangesInProfile(
    String name,
    String lastName,
    String email,
    String birthday,
    GenderInfo gender,
  ) {
    final userInfo = userState.value?.data;

    if ((userInfo?.name?.trim() ?? emptyString) != name.trim()) {
      return true;
    }
    if ((userInfo?.lastName?.trim() ?? emptyString) != lastName.trim()) {
      return true;
    }
    if ((userInfo?.email?.trim() ?? emptyString) != email.trim()) {
      return true;
    }

    if (userInfo?.gender != gender) {
      return true;
    }

    // Для упрощения чтения условия, разделил на несколько birthday
    if (_userInfo?.birthday == null && _selectedBirthdayAction.value != null) {
      return true;
    }

    if (_selectedBirthdayAction?.value != null) {
      if (_userInfo?.birthday != null) {
        if (_userInfo.birthday
            .isAtSameMomentAs(_selectedBirthdayAction.value)) {
          return true;
        }
      }
    }
    return false;
  }

  /// Когда объект получает фокус, прокручиваем его вверх виджета
  Future<void> _listenFocus() async {
    // необходимо для правильного срабатывания прокрутки
    await Future<void>.delayed(const Duration(milliseconds: 250));
    diff ??= renderManager.getDiffById(
      idFavoriteDishes,
      idTopWidget,
    );
    renderSize ??= renderManager.getRenderData(idFavoriteDishes);

    _updateHeightFavouriteWidget();
    if (focusNode.hasFocus) {
      await scrollController.animateTo(
        diff.yTop,
        duration: const Duration(milliseconds: 700),
        curve: Curves.ease,
      );
    } else {
      return heightFavoriteState.accept(0.0);
    }
  }

  void _updateHeightFavouriteWidget() {
    if (focusNode.hasFocus) {
      final bottomSize = bottomSizeState.value ?? 0.0;
      final renderSizeHeight = renderSize?.height ?? 0.0;

      final height = parentScaffoldKey.currentContext.size.height -
          (kToolbarHeight +
              heightTabsProfile +
              renderSizeHeight +
              bottomSize +
              12);
      heightFavoriteState.accept(height);
    }
  }

  @override
  void onBind() {
    super.onBind();
    subscribe<surf_mwwm.EntityState<UserInfo>>(
        userState.stream, _updateLocallyUserInfo);
    subscribe<bool>(_isShowAcceptButtonState, acceptButtonState.accept);
    subscribe<void>(onChangeBirthdayAction.stream, (_) => _showDatePicker());
    subscribe<String>(
      favoriteDishesController.stream.debounceTime(
        const Duration(milliseconds: 400),
      ),
      _searchFavoriteDishes,
    );
    subscribe<double>(
      bottomSizeState.stream,
      (_) => _updateHeightFavouriteWidget(),
    );
    bind<GenderInfo>(onSelectGenderAction, genderState.accept);

    bind<void>(
      onChangePhoneAction,
      (_) => _openScreen(AppRouter.replacementPhoneNumber),
    );
    bind<void>(onSaveAction, (_) => _updateUserInfo());
    bind<void>(onDeleteAccount, (_) => _deleteUserInfo());
    bind<FavouriteItem>(onRemoveFavouriteItem, _removeFavouriteItem);
    bind<FavouriteItem>(onSelectFavoriteItem, _selectFavouriteItem);
    bind<FocusNode>(onAddFocusWithError, _fieldsWithValidateError.add);
    bind<FocusNode>(
      onRemoveFocusWithError,
      (nodeToDelete) => _fieldsWithValidateError
          .removeWhere((node) => node.hashCode == nodeToDelete.hashCode),
    );
  }

  void _selectFavouriteItem(FavouriteItem item) {
    focusNode.unfocus();
    doFutureHandleError<void>(
      _userManager.addFavourite(item),
      (_) => favoriteDishesController.controller.clear(),
      onError: (e) => _showSnackBar(text: userDetailsWidgetFailSnackBarText),
    );
  }

  /// Удалить блюдо с экрана
  void _removeFavouriteItem(FavouriteItem item) {
    doFutureHandleError<void>(
        _userManager.removeFromFavourite(item.id.toString()), (_) => null,
        onError: (e) => _showSnackBar(text: userDetailsWidgetFailSnackBarText));
  }

  /// Поиск любимых блюд
  void _searchFavoriteDishes(String searchText) {
    final searchTextTrim = searchText.trim();

    if (searchTextTrim.isEmpty || searchTextTrim.length < 2) {
      searchFavoriteState.accept(surf_mwwm.EntityState.content());
      return;
    }
    doFutureHandleError<List<FavouriteItem>>(
      _userManager.searchFavourite(searchText),
      (items) =>
          searchFavoriteState.accept(surf_mwwm.EntityState.content(items)),
      onError: (e) => searchFavoriteState.accept(surf_mwwm.EntityState.error()),
    );
  }

  Future<void> _showDatePicker() async {
    _bottomSheetDatePickerDialogController.show(
      textTitle: userDetailsWidgetBirthdayText,
      onConfirm: (date, _) {
        _selectedBirthdayAction.accept(date);
        return birthdayController.controller.text = DateUtil.formatDate(date);
      },
    );
  }

  /// Обновить данные на сервере
  void _updateUserInfo() {
    if (!formKey.currentState.validate()) {
      if (_fieldsWithValidateError.isNotEmpty) {
        _fieldsWithValidateError.first.requestFocus();
      }
      return;
    }
    final updateProfile = UpdateProfile(
      birthday: _selectedBirthdayAction.value,
      gender: genderState.value,
      lastName: lastNameController.controller.text,
      name: nameController.controller.text,
      email: emailController.controller.text,
    );
    doFuture<void>(
      _userManager.updateUserInfo(updateProfile),
      (_) => _showSnackBar(
        text: userDetailsWidgetSuccessfullyText,
        pathIcon: icSuccessfully,
      ),
      onError: (_) => _showSnackBar(
        text: userDetailsWidgetFailSnackBarText,
        pathIcon: icArrowReload,
        callback: _updateUserInfo,
      ),
    );
    _userManager.updateUserInfo(updateProfile);
  }

  /// Удалить данные на сервере
  Future<void> _deleteUserInfo() async {
    final isAccepted = await _dialogController2.showAcceptBottomSheet(
      userDeleteQuestion,
      agreeText: deleteDialogAgree,
      cancelText: deleteDialogCancel,
    );
    if (isAccepted) {
      final String result = await _userManager.deleteUserInfo();
      if (result == '') await _authManager.logout();
      if (result != null && result != '') {
        handleError(MessagedException(result));
      }
    }
  }

  /// Получаем данные с сервера
  void _updateLocallyUserInfo(surf_mwwm.EntityState<UserInfo> entityState) {
    /// [_userInfo == null] - Если было неудачная попытка внести данные на сервер,
    /// а потом переключение на другой таб, то после возвращения заполняем поля
    /// ранее полученным профилем
    if (_userInfo == null || !entityState.hasError && !entityState.isLoading) {
      /// Избранное может меняться без нажатия на кнопку сохранить
      favouriteItemsState.accept(entityState.data.favourite);
      phoneController.controller.text = entityState.data?.phone;
      phoneController.accept(phoneController.controller.text);

      /// Проверка, что данные сохранились на сервере, и обновление прошло не из-за изменения любимых блюд
      if ((entityState.data.name != nameController.value ||
              entityState.data.lastName != lastNameController.value ||
              entityState.data.email != emailController.value ||
              DateUtil.formatDate(entityState.data.birthday) !=
                  nameController.value ||
              entityState.data.gender != genderState.value) &&
          _userInfo != null) {
        /// Просто для обновления состояния кнопки провоцирую поток на обновление
        genderState.accept(entityState?.data?.gender);
        return;
      }

      _userInfo = entityState.data;

      nameController.controller.text = _userInfo.name ?? emptyString;
      lastNameController.controller.text = _userInfo.lastName ?? emptyString;
      phoneController.controller.text = _userInfo.phone ?? emptyString;
      emailController.controller.text = _userInfo.email ?? emptyString;

      nameController.accept(nameController.controller.text);
      lastNameController.accept(lastNameController.controller.text);
      phoneController.accept(phoneController.controller.text);
      emailController.accept(emailController.controller.text);

      if (_userInfo.birthday != null) {
        birthdayController.controller.text =
            DateUtil.formatDate(_userInfo.birthday);
        lockBirthdayState.accept(true);
      }

      birthdayController.accept(
        birthdayController.controller.text ?? emptyString,
      );
      genderState.accept(_userInfo.gender);
    }
  }

  /// Показать снекбар
  Future<void> _showSnackBar({
    @required String text,
    String pathIcon,
    VoidCallback callback,
  }) async {
    await _showAcceptButtonState.accept(false);

    _messageController.showBaseSnackBar(
      text: text,
      pathAssetsIcon: pathIcon,
      callback: () {
        callback?.call();
        ScaffoldMessenger.of(parentScaffoldKey.currentState.context)
            .hideCurrentSnackBar();
      },
      afterClose: () => _showAcceptButtonState.accept(true),
    );
  }

  /// Открыть экран
  void _openScreen(String routeName) => _navigator.pushNamed(routeName);

  @override
  void dispose() {
    searchFavoriteState.dispose();
    super.dispose();
  }
}
