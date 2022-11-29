import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Виджет со списком подсказок
class Suggests extends StatelessWidget {
  Suggests({
    Key key,
    this.width,
    this.suggests,
    this.onSelect,
    this.maxHeight = 212.0,
    this.searchedText,
  }) : super(key: key);

  final double width;
  final double maxHeight;
  final List<String> suggests;
  final String searchedText;
  final Function(String) onSelect;

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: white,
          boxShadow: const [
            BoxShadow(
              color: shadow,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: maxHeight,
              minWidth: width,
              maxWidth: width,
            ),
            child: CupertinoScrollbar(
              thickness: 2,
              controller: scrollController,
              radius: const Radius.circular(2),
              isAlwaysShown: true,
              child: ListView.separated(
                shrinkWrap: true,
                controller: scrollController,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: suggests.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, index) => _SuggestTile(
                  searchedText: searchedText,
                  onSelect: onSelect,
                  suggest: suggests[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SuggestTile extends StatelessWidget {
  const _SuggestTile({
    Key key,
    @required this.suggest,
    this.onSelect,
    this.searchedText,
  })  : assert(suggest != null),
        super(key: key);

  final Function(String) onSelect;
  final String suggest;
  final String searchedText;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSelect == null ? null : () => onSelect(suggest),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 19, 8),
          child: RichText(
            text: TextSpan(
              style: textRegular14,
              children: _includeSearchedText()
                  ? [
                      TextSpan(
                        text: suggest.substring(0, _startIndex()),
                      ),
                      TextSpan(
                        style: TextStyle(color: Theme.of(context).accentColor),
                        text: suggest.substring(
                          _startIndex(),
                          _startIndex() + _length(),
                        ),
                      ),
                      TextSpan(
                        text: suggest.substring(_startIndex() + _length()),
                      ),
                    ]
                  : [TextSpan(text: suggest)],
            ),
          ),
        ),
      ),
    );
  }

  bool _includeSearchedText() =>
      suggest.toLowerCase().contains(searchedText.toLowerCase()) &&
      searchedText != '';

  int _startIndex() =>
      suggest.toLowerCase().indexOf(searchedText.toLowerCase().toString());

  int _length() => searchedText.length;
}
