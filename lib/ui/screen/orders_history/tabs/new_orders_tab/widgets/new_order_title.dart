import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/order/order_status.dart';
import 'package:uzhindoma/ui/common/widgets/svg_icon_button.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Заголовок нового заказа
class NewOrderTitle extends StatelessWidget {
  const NewOrderTitle({
    Key key,
    @required this.opacity,
    @required this.title,
    @required this.dateTitle,
    @required this.onDeleteTap,
    @required this.status,
  }) : super(key: key);

  final double opacity;
  final String title;
  final String dateTitle;
  final OrderStatus status;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: opacity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textMedium24),
              const SizedBox(height: 7),
              Text(dateTitle, style: textRegular12Secondary),
            ],
          ),
        ),
        const SizedBox(width: 18),
        _StatusWidget(status: status),
        const Spacer(),
        if (status != OrderStatus.canceled) _DeleteButton(onTap: onDeleteTap),
      ],
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({
    Key key,
    this.onTap,
  }) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SvgIconButton(
      icDelete,
      iconColor: iconColor,
      height: 24,
      width: 24,
      onTap: onTap,
    );
  }
}

class _StatusWidget extends StatelessWidget {
  const _StatusWidget({
    Key key,
    this.status,
  }) : super(key: key);
  final OrderStatus status;

  bool get isCanceled => status == OrderStatus.canceled;

  @override
  Widget build(BuildContext context) {
    if (status.title == null || status.title.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isCanceled ? colorError : textColorPrimary,
        ),
      ),
      child: Center(
        child: Text(
          status.title,
          style: isCanceled ? textMedium9Error : textMedium9,
        ),
      ),
    );
  }
}
