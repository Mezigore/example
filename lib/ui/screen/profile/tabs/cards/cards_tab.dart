import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/payment/payment_card.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/profile/tabs/cards/cards_tab_wm.dart';
import 'package:uzhindoma/ui/screen/profile/tabs/cards/di/cards_tab_component.dart';
import 'package:uzhindoma/ui/widget/cards/user_card_tile.dart';
import 'package:uzhindoma/ui/widget/error/error.dart';

/// Таб с информацией о картах пользователя
class CardsTab extends MwwmWidget<CardsTabComponent> {
  CardsTab({Key key})
      : super(
          widgetModelBuilder: createCardsScreenWidgetModel,
          dependenciesBuilder: (context) => CardsTabComponent(context),
          widgetStateBuilder: () => _CardsScreenState(),
          key: key,
        );
}

class _CardsScreenState extends WidgetState<CardsTabWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return EntityStateBuilder<List<PaymentCard>>(
      streamedState: wm.cardsState,
      loadingChild: _CardsTabPlaceholder(),
      errorChild: ErrorStateWidget(onReloadAction: wm.reloadAction),
      errorBuilder: (_, cards, error) {
        return _PaymentCardsList(
          cards: cards,
          onDeleteCard: wm.deleteCardAction,
          onAddCardTap: wm.addCardAction,
          onRefresh: wm.reloadAction,
          refreshStateStream: wm.reloadState.stream,
        );
      },
      loadingBuilder: (_, cards) {
        return _PaymentCardsList(
          isLoading: true,
          cards: cards,
          onDeleteCard: wm.deleteCardAction,
          onAddCardTap: wm.addCardAction,
          onRefresh: wm.reloadAction,
          refreshStateStream: wm.reloadState.stream,
        );
      },
      child: (_, cards) {
        return _PaymentCardsList(
          cards: cards,
          onDeleteCard: wm.deleteCardAction,
          onAddCardTap: wm.addCardAction,
          onRefresh: wm.reloadAction,
          refreshStateStream: wm.reloadState.stream,
        );
      },
    );
  }
}

class _PaymentCardsList extends StatelessWidget {
  const _PaymentCardsList({
    Key key,
    this.cards,
    this.onDeleteCard,
    this.onAddCardTap,
    this.isLoading = false,
    this.onRefresh,
    this.refreshStateStream,
  }) : super(key: key);

  final List<PaymentCard> cards;
  final ValueChanged<PaymentCard> onDeleteCard;
  final VoidCallback onAddCardTap;
  final bool isLoading;
  final Stream<SwipeRefreshState> refreshStateStream;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: cards == null || cards.isEmpty
                  ? _EmptyPlaceholder()
                  : SwipeRefresh.builder(
                      stateStream: refreshStateStream,
                      onRefresh: onRefresh,
                      itemCount: cards.length * 2 - 1,
                      itemBuilder: (_, index) {
                        if (index.isOdd) {
                          return const Divider(
                            color: dividerLightColor,
                            height: 1,
                          );
                        }
                        return UserCardTile(
                          key: ValueKey(cards[index ~/ 2].id),
                          cardName: cards[index ~/ 2].name,
                          onDeleteTap: () =>
                              onDeleteCard?.call(cards[index ~/ 2]),
                        );
                      },
                    ),
            ),
            SafeArea(
              top: false,
              left: false,
              right: false,
              child: AcceptButton(
                isLoad: isLoading,
                text: userCardsAddCard,
                padding: EdgeInsets.zero,
                callback: onAddCardTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 44.0),
      child: Text(
        userCardsEmptyCardsList,
        style: textRegular14Secondary,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _CardsTabPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          UserCardTileLoader(),
          SkeletonWidget(
            height: 1,
            isLoading: true,
          ),
          UserCardTileLoader(),
          SkeletonWidget(
            height: 1,
            isLoading: true,
          ),
          UserCardTileLoader(),
          Spacer(),
          SafeArea(
            top: false,
            left: false,
            right: false,
            child: SkeletonWidget(
              height: 56,
              width: double.infinity,
              isLoading: true,
            ),
          ),
        ],
      ),
    );
  }
}
