import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Chip в дизайне выбора даты
class DateChip extends StatelessWidget {
  const DateChip({
    Key key,
    this.onTap,
    this.label,
    this.isSelected,
  }) : super(key: key);

  final VoidCallback onTap;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: isSelected,
      label: Text(label),
      labelStyle: isSelected ? textMedium16Accent : textRegular16,
      onSelected: onTap == null ? null : (_) => onTap?.call(),
      selectedColor: colorPrimary,
      backgroundColor: bannerPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      labelPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
    );
  }
}
