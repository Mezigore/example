import 'package:flutter/material.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/catalog/week_item.dart';
import 'package:uzhindoma/ui/common/widgets/divider.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/res/animations.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/main/widget/app_bar/discount_button/discount_button.dart';

const double _splashRadius = 20.0;

/// Аппбар для основного экрана
class MainScreenAppBar extends StatefulWidget {
  const MainScreenAppBar({
    Key key,
    @required this.appBarState,
    @required this.currentWeekState,
    @required this.changeCurrentWeek,
  })  : assert(appBarState != null),
        assert(currentWeekState != null),
        assert(changeCurrentWeek != null),
        super(key: key);

  static const double appBarHeight = 48.0;

  final EntityStreamedState<List<WeekItem>> appBarState;
  final StreamedState<WeekItem> currentWeekState;

  final Action<WeekItem> changeCurrentWeek;

  @override
  _MainScreenAppBarState createState() => _MainScreenAppBarState();
}

class _MainScreenAppBarState extends State<MainScreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: EntityStateBuilder<List<WeekItem>>(
        streamedState: widget.appBarState,
        child: (ctx, weeks) => _AppBarContent(
          weeks: weeks,
          changeCurrentWeek: widget.changeCurrentWeek,
          currentWeekState: widget.currentWeekState,
        ),
        loadingChild: const _AppBarHolder(),
        errorChild: const _AppBarHolder(isLoading: false),
      ),
    );
  }
}

class _AppBarContent extends StatefulWidget {
  const _AppBarContent({
    Key key,
    @required this.weeks,
    @required this.currentWeekState,
    @required this.changeCurrentWeek,
  })  : assert(weeks != null && weeks.length > 0),
        assert(currentWeekState != null),
        assert(changeCurrentWeek != null),
        super(key: key);

  final List<WeekItem> weeks;
  final StreamedState<WeekItem> currentWeekState;
  final Action<WeekItem> changeCurrentWeek;

  @override
  __AppBarContentState createState() => __AppBarContentState();
}

class __AppBarContentState extends State<_AppBarContent> {
  bool _isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: backgroundColor,
          child: SizedBox(
            height: MainScreenAppBar.appBarHeight,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedSwitcher(
                  duration: baseAnimation,
                  child: _isCollapsed
                      ? _BurgerMenuButton(onPress: _showBurgerMenu)
                      : const SizedBox.shrink(),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        appBarWeekTitleDefault,
                        style: textRegular12Secondary,
                      ),
                      GestureDetector(
                        onTap: _showHideSelector,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            StreamedStateBuilder<WeekItem>(
                              streamedState: widget.currentWeekState,
                              builder: (_, item) {
                                return _WeekItemName(
                                  item: item,
                                  style: textMedium16,
                                );
                              },
                            ),
                            Icon(_isCollapsed
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_up)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: baseAnimation,
                  child: _isCollapsed
                      ? DiscountButton(
                          onPress: _showDiscountBottomSheet,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
        _isCollapsed
            ? const SizedBox.shrink()
            : Expanded(
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: _showHideSelector,
                      child: Container(
                        color: barrierColor,
                      ),
                    ),
                    _WeekSelector(
                      weeks: widget.weeks,
                      selectedItem: widget.currentWeekState.value,
                      onSelect: onSelectWeek,
                    )
                  ],
                ),
              )
      ],
    );
  }

  void _showHideSelector() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  void _showBurgerMenu() {
    if (_isCollapsed) {
      Scaffold.of(context).openDrawer();
    }
  }

  void _showDiscountBottomSheet() {
    if (_isCollapsed) {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return _DiscountBottomSheet();
        },
      );
    }
  }

  void onSelectWeek(WeekItem week) {
    setState(() {
      widget.changeCurrentWeek.accept(week);
      _isCollapsed = !_isCollapsed;
    });
  }
}

class _AppBarHolder extends StatefulWidget {
  const _AppBarHolder({Key key, this.isLoading = true}) : super(key: key);

  final bool isLoading;

  @override
  __AppBarHolderState createState() => __AppBarHolderState();
}

class __AppBarHolderState extends State<_AppBarHolder> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: SizedBox(
        height: MainScreenAppBar.appBarHeight,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _BurgerMenuButton(
              onPress: () => Scaffold.of(context).openDrawer(),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Меню недели', style: textRegular12Secondary),
                  const SizedBox(
                    height: 2,
                  ),
                  SkeletonWidget(
                    isLoading: widget.isLoading,
                    width: 135,
                    height: 22,
                  )
                ],
              ),
            ),
            DiscountButton(onPress: _showDiscountBottomSheet),
          ],
        ),
      ),
    );
  }

  void _showDiscountBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return _DiscountBottomSheet();
      },
    );
  }
}

/// Виджет выпадающего списка недель.
class _WeekSelector extends StatelessWidget {
  const _WeekSelector({
    Key key,
    @required this.weeks,
    @required this.selectedItem,
    @required this.onSelect,
  })  : assert(weeks != null),
        assert(selectedItem != null),
        assert(onSelect != null),
        super(key: key);

  final List<WeekItem> weeks;
  final WeekItem selectedItem;
  final void Function(WeekItem) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.0),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.fromLTRB(20.0, 7.0, 20.0, 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...weeks
              .map(
                (week) => _WeekItemWidget(
                  weekItem: week,
                  isSelected: week == selectedItem,
                  onSelect: onSelect,
                ),
              )
              .toList(),
          Column(
            children: [
              defaultDivider,
              _WeekInfoWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

/// Виджет отображения недели
class _WeekItemWidget extends StatelessWidget {
  const _WeekItemWidget({
    Key key,
    @required this.weekItem,
    this.isSelected = false,
    this.onSelect,
  })  : assert(weekItem != null),
        super(key: key);

  final WeekItem weekItem;
  final bool isSelected;

  final void Function(WeekItem) onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        defaultDivider,
        Material(
          color: backgroundColor,
          child: InkWell(
            onTap: () {
              onSelect?.call(weekItem);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _WeekItemName(
                          item: weekItem,
                          style: textRegular16,
                        ),
                        const SizedBox(height: 2.0),
                        Text(weekItem.description, style: textRegular12Hint),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                    child: isSelected
                        ? const Icon(Icons.check, color: colorAccent)
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

/// Виджет с подсказкой о доставке.
class _WeekInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(weekInfoText, style: textRegular14Secondary),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Icon(
              Icons.info_outline,
              color: iconColor,
            ),
          )
        ],
      ),
    );
  }
}

/// Кнопка вызова бургер-меню.
class _BurgerMenuButton extends StatelessWidget {
  const _BurgerMenuButton({Key key, this.onPress}) : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.only(left: 20, right: 16),
      splashRadius: _splashRadius,
      icon: const Icon(Icons.menu),
      onPressed: onPress,
    );
  }
}

/// Боттомшит с данными о скидке.
class _DiscountBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              discountBottomSheetTitle,
              style: textMedium16,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9.0, bottom: 32.0),
              child: Text(
                discountBottomSheetTempContent,
                style: textRegular14,
              ),
            ),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(closeButtonText),
              ),
            ),
            const SizedBox(height: 14,)
          ],
        ),
      ),
    );
  }
}

class _WeekItemName extends StatefulWidget {
  const _WeekItemName({
    Key key,
    @required this.item,
    @required this.style,
  })  : assert(item != null),
        assert(style != null),
        super(key: key);

  final WeekItem item;
  final TextStyle style;

  @override
  __WeekItemNameState createState() => __WeekItemNameState();
}

class __WeekItemNameState extends State<_WeekItemName> {
  String _uiName;

  @override
  void initState() {
    super.initState();

    _uiName = widget.item.uiName;
  }

  @override
  void didUpdateWidget(covariant _WeekItemName oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.item != widget.item) {
      _uiName = widget.item.uiName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _uiName,
      style: widget.style,
    );
  }
}
