import 'package:IITDAPP/ThemeModel.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

const initJS = '''
      function change(className,cssText) {
          var elems = document.querySelectorAll(className);
          var index = 0, length = elems.length;
          for ( ; index < length; index++) {
              elems[index].style.cssText = cssText;
          }
      }
      function removeAll(className) {
          var elems = document.querySelectorAll(className);
          var index = 0, length = elems.length;
          for ( ; index < length; index++) {
              elems[index].remove();
          }
      }
      removeAll('style');
  ''';

String getJS(bool dark) {
  final bgColor = dark ? '#212121' : '#fafafa';
  final textColor1 = dark ? '#a6a6a6' : '#595959';
  final textColor2 = dark ? '#ffffffc7' : 'black';
  final linkColor = dark ? '#3030F1c7' : '#3030F1';
  return '''
      document.querySelector('body').style.cssText="background-color:$bgColor;color:$textColor1;padding:10px;";
      change("[data-custom-class='body']","background-color:$bgColor; font-family: Arial;");
      change("[data-custom-class='title']","font-size: 26px; color:$textColor2; text-align: left;");
      change("[data-custom-class='subtitle']","font-size: 14px; color:$textColor1;");
      change("[data-custom-class='heading_1']","font-size: 19px; color:$textColor2;");
      change("[data-custom-class='heading_2']","font-size: 17px; color:$textColor2;");
      change("[data-custom-class='body_text']","font-size: 14px; color:$textColor1;");
      change("[data-custom-class='link']","font-size: 14px; color:$linkColor; text-decoration-line: none; font-weight: 600; word-break: break-word;");
      change("a span","color:none");
      change("span[data-custom-class='body_text'] span","color:none");
  ''';
}

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool pageLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
        appBar: GradientAppBar(
          title: Text('Privacy Policy'),
          backgroundColorStart:
              Provider.of<ThemeModel>(context).theme.APP_BAR_START,
          backgroundColorEnd:
              Provider.of<ThemeModel>(context).theme.APP_BAR_END,
        ),
        body: Stack(children: [
          WebView(
              initialUrl: 'https://auth.devclub.in/privacy-policy',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: (String url) {
                _controller.future.then((controller) {
                  controller.evaluateJavascript(initJS);
                  final isDarkMode =
                      Provider.of<ThemeModel>(context, listen: false)
                              .themeType ==
                          ThemeType.Dark;
                  controller.evaluateJavascript(getJS(isDarkMode));
                  Future.delayed(
                      Duration(milliseconds: 500),
                      () => setState(() {
                            pageLoaded = true;
                          }));
                });
              }),
          if (!pageLoaded)
            SizedBox.expand(
              child: Container(
                color:
                    Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
                child: Center(child: CircularProgressIndicator()),
              ),
            )
        ]));
  }

  void runJavascript(controller) {}
}
