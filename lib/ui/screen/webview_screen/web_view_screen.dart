import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/widget/error/error.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Экран с вебвью, чтобы переход по ссылкам оставался в рамках приложения
class WebViewScreen extends StatefulWidget {
  WebViewScreen({
    Key key,
    this.url,
    this.needAppBar = false,
  }) : super(key: key);

  final String url;
  final bool needAppBar;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final _errorState = StreamedState<bool>(false);

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: widget.needAppBar
          ? const DefaultAppBar(leadingIcon: Icons.arrow_back_ios)
          : null,
      body: SafeArea(
        bottom: false,
        child: StreamedStateBuilder<bool>(
          streamedState: _errorState,
          builder: (_, hasError) {
            if (hasError) return ErrorStateWidget(onReloadAction: _closeError);
            return WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebResourceError: (error) => _onError(error, context),
              navigationDelegate: (navigation) => _navigationDelegate(
                navigation,
                context,
              ),
            );
          },
        ),
      ),
    );
  }

  void _closeError() {
    _errorState.accept(false);
  }

  void _onError(WebResourceError error, BuildContext context) {
    _errorState.accept(true);
  }

  FutureOr<NavigationDecision> _navigationDelegate(
    NavigationRequest navigation,
    BuildContext context,
  ) {
    if (navigation.url.contains('fail')) {
      Navigator.pop(context, false);
    }
    if (navigation.url.contains('success')) {
      Navigator.pop(context, true);
    }
    return NavigationDecision.navigate;
  }
}
