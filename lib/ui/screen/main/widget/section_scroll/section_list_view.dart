import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uzhindoma/ui/res/animations.dart';
import 'package:uzhindoma/ui/screen/main/widget/section_scroll/section.dart';

import '../../../../res/colors.dart';

/// Функция для сбора отображения данных секции.
typedef SectionContentBuilder<T> = Widget Function(
  BuildContext context,
  Section<T> section,
);

/// Функция сбора заголовка секции.
typedef SectionTitleContentBuilder = Widget Function(
  BuildContext context,
  String title, {
  bool isSelected,
});

/// Скроллящийся лист объктов, разделенных на секции.
/// Состоит из прокручивающегося списка с контентом и заголовка для отображения
/// и манипулирования позицией отображения.
///
/// Параметр [sections] используется для передачи отображаемых данных.
/// Отображение этих данных определяет [contentBuilder].
///
/// Для кастомизации физики скролла контента используйте параметр
/// [contentScrollPhysics]. В случае, если параметр не задан, используется
/// стандартная для системы физика.
///
/// Кастомизация отображения заголовка достигается параметрами [headerHeight],
/// [headerElevation], [headerColor]. За отображение заголовка каждой секции
/// отвечает [headerTitleBuilder], в случае если не задан, используется
/// стандартное отображение.
class SectionListView<T> extends StatefulWidget {
  const SectionListView({
    Key key,
    @required this.sections,
    @required this.contentBuilder,
    this.headerTitleBuilder,
    this.headerHeight = 50,
    this.headerElevation = 8.0,
    this.headerSideSpace = 8.0,
    this.headerColor,
    this.contentScrollPhysics,
    this.scrollController,
  })  : assert(sections != null && sections.length > 0),
        assert(contentBuilder != null),
        super(key: key);

  final List<Section<T>> sections;
  final ScrollPhysics contentScrollPhysics;
  final double headerHeight;
  final double headerElevation;
  final double headerSideSpace;
  final Color headerColor;

  final SectionTitleContentBuilder headerTitleBuilder;
  final SectionContentBuilder<T> contentBuilder;

  final ScrollController scrollController;

  @override
  _SectionListViewState createState() => _SectionListViewState<T>();
}

class _SectionListViewState<T> extends State<SectionListView<T>> {
  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();

  int _currentSelected = 0;
  bool _autoScrolling = false;

  @override
  void initState() {
    super.initState();

    _itemPositionsListener.itemPositions.addListener(_positionListener);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            SizedBox(height: widget.headerHeight),
            Expanded(
              child: ScrollablePositionedList.builder(
                itemCount: widget.sections.length,
                itemBuilder: (context, index) {
                  return widget.contentBuilder(context, widget.sections[index]);
                },
                physics: widget.contentScrollPhysics,
                itemScrollController: _itemScrollController,
                itemPositionsListener: _itemPositionsListener,
              ),
            ),
          ],
        ),
        Material(
          elevation: widget.headerElevation,
          color: widget.headerColor,
          child: _SectionHeader(
            sections: widget.sections,
            selected: widget.sections[_currentSelected],
            onSectionChange: _onSelectSection,
            headerTitleBuilder: widget.headerTitleBuilder,
            headerHeight: widget.headerHeight,
            headerSideSpace: widget.headerSideSpace,
          ),
        ),
      ],
    );
  }

  void _onSelectSection(Section<T> section) {
    if (_autoScrolling) return;

    final targetIndex = widget.sections.indexOf(section);

    setState(
      () {
        _autoScrolling = true;
        _currentSelected = targetIndex;

        final scrollFuture = _itemScrollController.scrollTo(
          index: targetIndex,
          duration: slowAnimation,
        );

        // trick to make code formatting readable, no more
        // ignore: cascade_invocations
        scrollFuture.then(
          (_) {
            _autoScrolling = false;
          },
        );
      },
    );
  }

  void _positionListener() {
    if (_autoScrolling) return;

    final positions = _itemPositionsListener.itemPositions.value;

    if (positions == null || positions.isEmpty) return;

    final min = positions
        .where((position) => position.itemTrailingEdge > 0)
        .reduce((min, position) => position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
        .index;

    if (_currentSelected != min) {
      setState(() {
        _currentSelected = min;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    _itemPositionsListener.itemPositions.removeListener(_positionListener);
  }
}

class _SectionHeader<T> extends StatefulWidget {
  _SectionHeader({
    Key key,
    @required this.sections,
    @required this.selected,
    this.onSectionChange,
    this.headerHeight = 50,
    this.headerSideSpace,
    this.headerTitleBuilder,
  })  : assert(sections != null && sections.isNotEmpty),
        assert(selected != null),
        assert(sections.contains(selected)),
        super(key: key);

  final List<Section<T>> sections;
  final Section<T> selected;
  final Function(Section<T>) onSectionChange;
  final double headerHeight;
  final double headerSideSpace;

  final SectionTitleContentBuilder headerTitleBuilder;

  @override
  __SectionHeaderState<T> createState() => __SectionHeaderState<T>();
}

class __SectionHeaderState<T> extends State<_SectionHeader<T>> {
  final _sectionScrollController = ItemScrollController();

  @override
  void didUpdateWidget(covariant _SectionHeader<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selected != widget.selected) {
      final targetIndex = widget.sections.indexOf(widget.selected);
      _sectionScrollController.scrollTo(
        index: targetIndex,
        duration: const Duration(microseconds: 300),
        alignment: 0.5,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ///Хардкод новогодней кнопки
    /// При ее отключении вернуть закоменченный код
    return SizedBox(
      height: widget.headerHeight,
      child: ScrollablePositionedList.builder(
        itemCount: widget.sections.length + 1 /*widget.sections.length*/,
        itemBuilder: (_, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                height: 60,
                alignment: Alignment.center,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16.0),
                  onTap: ()async{
                    final Uri _url = Uri.parse('https://uzhindoma.ru/new-year/');
                    if (!await launchUrl(_url)) {
                    throw 'Could not launch $_url';
                    }
                  },
                  child: Row(
                    children: const [
                      Text(
                        'Новогоднее меню',
                        style: TextStyle(color: cookBeforeBackground),
                      ),
                      SizedBox(width: 4,),
                      Icon(Icons.star, color: cookBeforeBackground, size: 18,),
                    ],
                  ),
                ),
              ),
            );
          } else {
            final section = widget.sections[index - 1 /*index*/];

            EdgeInsets padding;
            final space = widget.headerSideSpace ?? 0;
            if (space > 0) {
              if (index == 1 /*0*/) {
                padding = EdgeInsets.only(left: space);
              } else if (index == widget.sections.length /* - 1*/) {
                padding = EdgeInsets.only(right: space);
              }
            }

            return _SectionTitle(
              key: ObjectKey(section),
              section: section,
              isSelected: section == widget.selected,
              onTap: widget.onSectionChange,
              contentBuilder: widget.headerTitleBuilder,
              padding: padding,
            );
          }
        },
        scrollDirection: Axis.horizontal,
        itemScrollController: _sectionScrollController,
        physics: const ClampingScrollPhysics(),
      ),
    );
  }
}

class _SectionTitle<T> extends StatelessWidget {
  const _SectionTitle({
    Key key,
    @required this.section,
    this.isSelected = false,
    this.onTap,
    this.padding,
    SectionTitleContentBuilder contentBuilder,
  })  : contentBuilder = contentBuilder ?? _defaultSectionTitleContentBuilder,
        assert(section != null),
        super(key: key);

  final Section<T> section;
  final bool isSelected;
  final Function(Section<T>) onTap;
  final SectionTitleContentBuilder contentBuilder;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    Widget title = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (onTap != null) onTap(section);
      },
      child: contentBuilder(context, section.name, isSelected: isSelected),
    );

    if (padding != null) {
      title = Padding(
        padding: padding,
        child: title,
      );
    }

    return title;
  }
}

Widget _defaultSectionTitleContentBuilder(
  BuildContext context,
  String title, {
  bool isSelected,
}) {
  final theme = Theme.of(context);
  var textStyle = DefaultTextStyle.of(context).style;
  if (isSelected) {
    final selectedTextColor = theme.brightness == Brightness.light ? Colors.white : Colors.black;
    textStyle = textStyle.copyWith(color: selectedTextColor);
  }

  return Container(
    decoration: isSelected ? BoxDecoration(color: theme.accentColor) : null,
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Text(title, style: textStyle),
    ),
  );
}
