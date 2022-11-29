import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uzhindoma/ui/res/assets.dart';

/// Лого "Ужин дома"
class LogoWidget extends StatelessWidget {
  const LogoWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        Center(
          child: SvgPicture.asset(icLogo),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
