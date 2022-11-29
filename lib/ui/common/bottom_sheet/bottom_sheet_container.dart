import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/colors.dart';

/// Стандартный контейнер для шторки
class BottomSheetContainer extends StatefulWidget {
  const BottomSheetContainer({
    Key key,
    this.child,
  }) : super(key: key);
  final Widget child;

  @override
  _BottomSheetContainerState createState() => _BottomSheetContainerState();
}

class _BottomSheetContainerState extends State<BottomSheetContainer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Material(
        color: white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              16,
            ),
            topRight: Radius.circular(
              16,
            ),
          ),
        ),
        child: SafeArea(
          child: widget.child,
        ),
      ),
    );
  }
}
