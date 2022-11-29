import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/order/base/history_item.dart';
import 'package:uzhindoma/domain/order/orders_history_item.dart';
import 'package:uzhindoma/domain/order/orders_history_raiting.dart';
import 'package:uzhindoma/ui/res/animations.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';

/// Карточки товара для оценки
class RateCardWidget extends StatefulWidget {
  const RateCardWidget({
    Key key,
    @required this.item,
    this.onChangeRating,
    bool isEnabled,
  })  : assert(item != null),
        isEnabled = isEnabled ?? false,
        super(key: key);

  final HistoryItem item;
  final bool isEnabled;
  final ValueChanged<OrdersHistoryRating> onChangeRating;

  @override
  State<StatefulWidget> createState() => _RateCardWidgetState();
}

class _RateCardWidgetState extends State<RateCardWidget> {
  static const _radius = Radius.circular(16);
  final _commentTextController = TextEditingController();
  VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    if (widget.isEnabled) {
      _listener = () => widget.onChangeRating?.call(
            widget.item.getRating
                .copyWith(comment: _commentTextController.text),
          );
      _commentTextController.addListener(_listener);
    }
    if (widget.item.comment != null) {
      _commentTextController.text = widget.item.comment;
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.isEnabled) {
      _commentTextController
        ..removeListener(_listener)
        ..dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(_radius),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Image(
            url: widget.item.img,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.item.name, style: textMedium16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.isEnabled ? rateNoRatedTitle : rateRatedDishTitle,
              style: textRegular14,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
            child: _Rating(
              selected: widget.item.getRating.itemRating,
              isEnabled: widget.isEnabled,
              onRateChange: _rateDish,
            ),
          ),
          const SizedBox(height: 20),
          if (widget.item is OrdersHistoryItem && widget.isEnabled) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(rateRateRecipeTitle, style: textRegular14),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
              child: _Rating(
                selected: widget.item.getRating.recipeRating,
                isEnabled: widget.isEnabled,
                onRateChange: _rateRecipe,
              ),
            ),
            const SizedBox(height: 20),
          ],
          !widget.isEnabled && (_commentTextController.text?.isEmpty ?? true)
              ? const SizedBox.shrink()
              : Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                  child: TextFormField(
                    controller: _commentTextController,
                    maxLines: 3,
                    minLines: 1,
                    enabled: widget.isEnabled,
                    style: widget.isEnabled
                        ? textRegular16
                        : textRegular16Secondary,
                    decoration: const InputDecoration(
                      labelText: commentLabel,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void _rateRecipe(int rate) {
    widget.onChangeRating?.call(
      widget.item.getRating.copyWith(recipeRating: rate),
    );
  }

  void _rateDish(int rate) {
    widget.onChangeRating?.call(
      widget.item.getRating.copyWith(itemRating: rate),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({Key key, this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: _RateCardWidgetState._radius,
        topLeft: _RateCardWidgetState._radius,
      ),
      child: AspectRatio(
        aspectRatio: 335 / 222,
        child: ProductImageWidget(urlImage: url),
      ),
    );
  }
}

class _Rating extends StatelessWidget {
  const _Rating({
    Key key,
    this.onRateChange,
    this.isEnabled = true,
    this.selected,
  }) : super(key: key);

  final bool isEnabled;
  final int selected;
  final ValueChanged<int> onRateChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) {
          final value = index + 1;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: isEnabled ? () => onRateChange?.call(value) : null,
                child: _RateItem(
                  value: value,
                  isEnabled: isEnabled,
                  isSelected: value == selected,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RateItem extends StatelessWidget {
  const _RateItem({
    Key key,
    @required this.value,
    bool isSelected,
    bool isEnabled,
  })  : assert(value != null),
        isSelected = isSelected ?? false,
        isEnabled = isEnabled ?? false,
        super(key: key);

  final int value;
  final bool isSelected;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: fastAnimation,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? colorPrimary : textFormFieldFillColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        value.toString(),
        style: isSelected
            ? textMedium16Accent
            : isEnabled
                ? textRegular16
                : textRegular16Grey,
      ),
    );
  }
}
