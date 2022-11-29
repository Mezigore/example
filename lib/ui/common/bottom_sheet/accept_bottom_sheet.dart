import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/bottom_sheet/bottom_sheet_container.dart';
import 'package:uzhindoma/ui/res/button_styles.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// BottomSheet с подтверждением
class AcceptBottomSheet extends StatefulWidget {
  const AcceptBottomSheet({
    Key key,
    this.title,
    this.agreeText,
    this.cancelText,
    this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String agreeText;
  final String cancelText;

  @override
  _AcceptBottomSheetState createState() => _AcceptBottomSheetState();
}

class _AcceptBottomSheetState extends State<AcceptBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.title,
              style: textMedium16,
              textAlign: TextAlign.center,
            ),
          ),
          if (widget.subtitle != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.subtitle,
                style: textRegular14Hint,
                textAlign: TextAlign.center,
              ),
            )
          ],
          const SizedBox(height: 24),
          if (widget.cancelText != null)
            Container(
              height: 48,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: primaryButtonStyle.style,
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(widget.cancelText),
              ),
            ),
          if (widget.agreeText != null) ...[
            const SizedBox(height: 16),
            Container(
              height: 48,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: accentButtonStyle.style,
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(widget.agreeText),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}
