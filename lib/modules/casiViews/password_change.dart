// TODO: See how to set cookies for casi

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const String passwordChangeUrl = 'https://auth.devclub.in/profile/settings';

void launchPasswordChangeScreen(String _token, context) async {
  final webview = FlutterWebviewPlugin();
  webview.onBack.listen((_) {
    webview.close();
  });
  webview.onStateChanged.listen((state) {
    if (state.type == WebViewState.finishLoad) {
      webview.resize(Rect.fromLTRB(
        MediaQuery.of(context).padding.left,
        MediaQuery.of(context).padding.top,
        MediaQuery.of(context).size.width + 1,
        MediaQuery.of(context).size.height + 1,
      ));
    }
  });
  webview.onUrlChanged.listen((url) async {
    print('URL CHANGED: $url');
  });
  await webview.launch(
    passwordChangeUrl,
    ignoreSSLErrors: true,
    clearCookies: true,
    clearCache: true,
    headers: {'Cookie': 'rememberme=$_token;'},
    userAgent:
        'Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19',
  );
}
