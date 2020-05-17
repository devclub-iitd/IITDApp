import 'package:url_launcher/url_launcher.dart';

class UrlHandler{

  static Future<void> launchInBrowser(String url,{launchInApp = false}) async{
    if(await canLaunch(url)){
      var nativeApp = false;
      if(!launchInApp) {
        nativeApp = await launch(url,forceSafariVC: false,universalLinksOnly: true);
      }
      if(!nativeApp) {
        await launch(url,forceSafariVC: launchInApp,forceWebView: launchInApp);
      }
    }
    else{
      print(url);
      throw 'Cannot Launch requested url';
    }
  }

  static Future<void> makePhoneCall(String number) async{
    var url = 'tel:'+number;
    if(await canLaunch(url)){
      await launch(url);
    }
    else {
      throw 'Could not place phone call';
    }
  }

}



