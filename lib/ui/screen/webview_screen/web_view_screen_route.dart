import 'package:flutter/material.dart';

// ignore: always_use_package_imports
import 'web_view_screen.dart';

/// Роут для [WebViewScreen]
class WebViewScreenRoute extends MaterialPageRoute<bool> {
  WebViewScreenRoute(
    String url, {
    bool needAppbar = false,
  }) : super(
          builder: (ctx) => WebViewScreen(
            url: url,
            needAppBar: needAppbar,
          ),
        );
}
