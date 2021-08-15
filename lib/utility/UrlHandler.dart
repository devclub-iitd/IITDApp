import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class UrlHandler {
  static Future<void> launchInBrowser(String url, {launchInApp = false}) async {
    if (await canLaunch(url)) {
      var nativeApp = false;
      if (!launchInApp) {
        nativeApp =
            await launch(url, forceSafariVC: false, universalLinksOnly: true);
      }
      if (!nativeApp) {
        await launch(url,
            forceSafariVC: launchInApp, forceWebView: launchInApp);
      }
    } else {
      print(url);
      throw 'Cannot Launch requested url';
    }
  }

  static Future<void> launchDeviceCalendar() async {
    var url = '';
    if (Platform.isAndroid) {
      // Android-specific code
      url = 'content://com.android.calendar/time/';
    } else if (Platform.isIOS) {
      // iOS-specific code
      // This should be tested for.
      url = 'calshow://';
    }
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static Future<void> makePhoneCall(String number) async {
    var url = 'tel:' + number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not place phone call';
    }
  }

  static Future<void> startEmail(String mail,
      {String subject = '', String body = ''}) async {
    final params = Uri(
      scheme: 'mailto',
      path: '$mail',
      query: 'subject=$subject&body=$body', //add subject and body here
    );
    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not email';
    }
  }
}
