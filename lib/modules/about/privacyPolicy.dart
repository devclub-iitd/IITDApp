import 'dart:convert';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/utility/UrlHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
        appBar: AppBar(
          title: Text('Privacy Policy'),
          backgroundColor: Provider.of<ThemeModel>(context).theme.APP_BAR_START,
        ),
        body: Stack(children: [
          WebView(
            initialUrl: 'about:blank',
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              _loadHtmlFromAssets();
            },
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              print('blocking navigation to $request}');
              UrlHandler.launchInBrowser(request.url);
              return NavigationDecision.prevent;
            },
          ),
        ]));
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/privacy-policy.html');
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
