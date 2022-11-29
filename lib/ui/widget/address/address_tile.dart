import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Виджет для отображения адреса в списке
class AddressTile extends StatelessWidget {
  const AddressTile({
    Key key,
    @required this.address,
    this.onPress,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    bool needFullAddress,
  })  : assert(address != null),
        assert(padding != null),
        needFullAddress = needFullAddress ?? false,
        super(key: key);

  /// Адрес
  final UserAddress address;

  /// Отступ
  /// Встроен в виджет для того, чтобы внешний отступ не обризал Ripple эффект
  final EdgeInsets padding;

  /// Нажатие на ячейкук
  final Function(UserAddress) onPress;

  /// Нужно ли выводить полный адрес
  final bool needFullAddress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress == null ? null : () => onPress(address),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),
                  Text(
                    needFullAddress
                        ? address?.fullName?.trim()
                        : address?.name?.trim() ?? address?.street?.trim(),
                    style: textRegular16,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  if (address?.cityName != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      address.cityName.trim(),
                      style: textRegular14Secondary,
                    ),
                  ],
                  const SizedBox(height: 14),
                ],
              ),
            ),
            SvgPicture.asset(
              icArrowRight,
              height: 24,
              width: 24,
            ),
          ],
        ),
      ),
    );
  }
}
