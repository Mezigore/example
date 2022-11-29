import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/payment/payment_card.dart';
import 'package:uzhindoma/interactor/common/urls.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/common/reload/reload_mixin.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';

/// [WidgetModel] для <CardsScreen>
class CardsTabWidgetModel extends WidgetModel with ReloadMixin {
  CardsTabWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._userManager,
    this._dialogController,
  ) : super(dependencies);

  final NavigatorState _navigator;
  final UserManager _userManager;
  final DefaultDialogController _dialogController;

  final addCardAction = Action<void>();
  final deleteCardAction = Action<PaymentCard>();

  EntityStreamedState<List<PaymentCard>> get cardsState =>
      _userManager.userCardsState;

  @override
  void onLoad() {
    super.onLoad();
    _loadCards();
  }

  @override
  void onBind() {
    super.onBind();
    bind(deleteCardAction, _deleteCard);
    bind<void>(addCardAction, (_) => _openAddCardScreen());
  }

  @override
  void reloadData() {
    _loadCards();
  }

  void _loadCards() {
    doFutureHandleError<void>(
      _userManager.loadUserCards(),
      (_) => reloadState.accept(SwipeRefreshState.hidden),
      onError: (_) => reloadState.accept(SwipeRefreshState.hidden),
    );
  }

  Future<void> _openAddCardScreen() async {
    if (_userManager.id == null) return;
    final isSuccessAdded = await _navigator.pushNamed<bool>(
      AppRouter.webViewScreen,
      arguments: PaymentUrls.addCardToUser(_userManager.id),
    );
    if (isSuccessAdded ?? false) _loadCards();
  }

  Future<void> _deleteCard(PaymentCard card) async {
    final needDelete = await _dialogController.showAcceptBottomSheet(
      userCardsNeedDelete,
      agreeText: deleteDialogAgree,
      cancelText: deleteDialogCancel,
    );

    if (!(needDelete ?? false)) return;
    doFutureHandleError<void>(
      _userManager.deleteCard(card.id),
      (_) => reloadState.accept(SwipeRefreshState.hidden),
      onError: (_) => reloadState.accept(SwipeRefreshState.hidden),
    );
  }
}
