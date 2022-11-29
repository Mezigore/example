import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/util/const.dart';

/// Виджет выделяющий символы по совпадению
class SuggestTileWidget extends StatelessWidget {
  const SuggestTileWidget({
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
      searchedText != emptyString;

  int _startIndex() =>
      suggest.toLowerCase().indexOf(searchedText.toLowerCase().toString());

  int _length() => searchedText.length;
}
