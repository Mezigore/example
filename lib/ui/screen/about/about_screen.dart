import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uzhindoma/domain/core.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/business_string.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Экран О сервисе
class AboutScreen extends StatefulWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        leadingIcon: Icons.arrow_back_ios,
        title: aboutServiceMainDrawerWidgetText,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const _Divider(),
            _Tile(
              title: aboutScreenUserAgreement,
              onTap: () => Navigator.of(context).pushNamed(
                AppRouter.webViewScreen,
                arguments: Pair(aboutUseAgreement, true),
              ),
            ),
            const _Divider(),
            _Tile(
              title: aboutScreenBlog,
              onTap: () => Navigator.of(context).pushNamed(
                AppRouter.webViewScreen,
                arguments: Pair(aboutBlog, true),
              ),
            ),
            const _Divider(),
            _Tile(
              title: aboutScreenFAQ,
              onTap: () => Navigator.of(context).pushNamed(
                AppRouter.webViewScreen,
                arguments: Pair(aboutFAQ, true),
              ),
            ),
            const _Divider(),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    Key key,
    @required this.title,
    this.onTap,
  })  : assert(title != null),
        super(key: key);
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 54,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: textRegular16),
              SvgPicture.asset(icArrowRight),
            ],
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(thickness: 1, color: dividerLightColor),
    );
  }
}
