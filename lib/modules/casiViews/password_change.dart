// TODO: See how to set cookies for casi

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

final String passwordChangeUrl = 'https://auth.devclub.in/profile/settings';

void launchPasswordChangeScreen(String _token) async{
  final webview =  FlutterWebviewPlugin();
  webview.onUrlChanged.listen((url) async {
    print('URL CHANGED: $url');
  });
  await webview.launch(
    passwordChangeUrl,
    ignoreSSLErrors: true,
    clearCookies: true,
    clearCache: true,
    headers: {'Cookie': 'rememberme=${_token};'},
    userAgent:
    'Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19',
  );
}
