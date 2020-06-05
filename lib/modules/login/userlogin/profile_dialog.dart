import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:IITDAPP/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

import 'package:IITDAPP/modules/events/globals.dart';
import 'package:pedantic/pedantic.dart';

import '../LoginScreen.dart';

// Future<Stream<String>> _server() async {
//   final StreamController<String> onCode = new StreamController();
//   HttpServer server =
//       await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8080);
//   server.listen((HttpRequest request) async {
//     final String code = request.uri.queryParameters["code"];
//     request.response
//       ..statusCode = 200
//       ..headers.set("Content-Type", ContentType.HTML.mimeType)
//       ..write("<html><h1>You can now close this window</h1></html>");
//     await request.response.close();
//     await server.close(force: true);
//     onCode.add(code);
//     await onCode.close();
//   });
//   return onCode.stream;
// }

// Future<Null> getToken() async {
//   Stream<String> onCode = await _server();
//   String url =
//       "https://www.facebook.com/dialog/oauth?client_id=826437701076131&redirect_uri=http://localhost:8080/&scope=public_profile";
//     launch(url);
//   final String code = await onCode.first;
//   print(code);
//   // final response = await http.post("http://192.168.43.231:5000/api/users/facebookLogin", body: {"code" : code});
// }

Future logout() async {
  final storage = FlutterSecureStorage();
  await storage.delete(key: 'email');
  await storage.delete(key: 'password');
  await storage.delete(key: 'token');
}

void showAlert(BuildContext context, Function onlogout) {
  if(currentUser==null){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.indigo[600],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  // getToken();
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                },
                color: Colors.indigo[400],
                child: Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  else {
    var role = currentUser.email;
    var name = (currentUser.name == null) ? 'User Name' : currentUser.name;
    // String url = "https://www.facebook.com/v3.3/dialog/oauth?client_id=826437701076131&redirect_uri=https://www.facebook.com/connect/login_success.html&state={st=state123abc,ds=123456789}";
    // if (currentUser.isAdmin) {
    //   role = '${currentUser.adminof[0].clubName} Admin';
    // } else {
    //   role = 'Student';
    // }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.indigo[600],
          titlePadding: EdgeInsets.only(
            top: 20,
          ),
          contentPadding: EdgeInsets.only(top: 5, bottom: 20),
          title: Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 30),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  role,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              FlatButton(
                onPressed: () async {
                  // getToken();
                  Navigator.pop(context);
                  showLoading(context, message: 'Signing Out');
                  await logout();
                  Navigator.pop(context);
                  onlogout();
                },
                color: Colors.indigo[400],
                child: Text(
                  'LOGOUT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// https://www.facebook.com/connect/login_success.html?code=AQCUkRo-CnWGu6UUStW7b8vmK4CtgKRO5qB1a6uiYk6jR58xAZMPkFmMb9k52SyjWJ9jKmHY1lw0EMdqHf9qtm6J3ej-UK1aCYosZf89gMqWOCsFOWjJIJAs-meQXd0gLdaTvghgmHcvZ0jjmJeZ_WyqAujWSlbmmRihGnHt1t5NzpYvp3TN4M6l8r3b54Ny8O7Nl4BQJByqiuu7plU76sDvQoexfif04A6gSko5nd6U8GmHckLzz71Ju2HutKNlmRtmJE89OPG3_IiqqrqQdo4mT9WrLZZi-nOPET_ezdAiDvUEvMcEJtD0jju8SngIg0xZkIXRAHe3asp0XH8yIixUuX4LFVF9YZ3DwD_SMLr5LQ&state=%7Bst%3Dstate123abc%2Cds%3D123456789#_=_