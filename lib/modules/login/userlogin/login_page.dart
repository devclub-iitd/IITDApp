import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/login/user_class.dart';
// import 'package:IITDAPP/modules/login/userlogin/signup_page.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:IITDAPP/widgets/error_alert.dart';
import 'package:IITDAPP/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
// import 'package:validators/validators.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../casi_user.dart';

void onLoginSuccess(
    BuildContext context, String newtoken, Function onlogin) async {
  print('newtoken: $newtoken');
  // ignore: unawaited_futures
  showLoading(context);
  final storage = FlutterSecureStorage();
  print('Getting User Info');
  final response = await http
      .get('$url/api/user/me', headers: {'authorization': 'Bearer $newtoken'});
  print('got user info response');
  if (response.statusCode == 200) {
    var parsedJson = json.decode(response.body);
    currentUser = User.fromJson(parsedJson['data']);
    print('Login successful');
    print('newtoken : $newtoken');
    await storage.write(key: 'token', value: newtoken);
    print('token stored');
    var topr = await storage.read(key: 'token');
    print(topr);
    token = newtoken;
    Navigator.pop(context);
    onlogin();
  } else {
    print('Could not get user info.');
    Navigator.pop(context);
    await showErrorAlert(
        context, 'Login Failed', 'Something went wrong. Please Try Again');
  }
}

Future login(BuildContext context, Function onlogin, {bool pop = true}) async {
  print('loggin in');
  final storage = FlutterSecureStorage();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  var oldToken = await storage.read(key: 'token');
  var clientId = '5f7ca56f01cb380034260a02';
  var secret =
      'o8ggsY3EeNeCdl0U3izDF1LvR0cU33zopJeFHltapvle8bBChvzHT5miRN23o5v0';

  try {
    print('trying old token');
    print(oldToken);
    // ignore: unused_local_variable
    var user = await CasiLogin.fromToken(oldToken).refreshToken(
        onRefreshSuccess: (String newToken) {
      print(newToken);
      onLoginSuccess(context, newToken, onlogin);
    });
  } catch (e) {
    await CasiLogin(clientId, secret, onSuccess: (String token, CasiUser user) {
      onLoginSuccess(context, token, onlogin);
    }, onError: (dynamic e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('An Error Occured!'),
          content: Text(e.toString()),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Try Again'),
            )
          ],
        ),
      );
      print(e);
    }).signIn();
  }
}

class LoginPage extends StatefulWidget {
  final Function onlogin;

  LoginPage({this.onlogin});

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  // ignore: unused_field
  final _key = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   var storage = FlutterSecureStorage();
  //   var token = await storage.read(key: 'token');

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeModel>(context).theme.LOGIN_BACKGROUND,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: FlatButton(
                      child: Text('LOGIN'),
                      color: Provider.of<ThemeModel>(context)
                          .theme
                          .LOGIN_BUTTON_COLOR,
                      onPressed: () async {
                        // unawaited(showLoading(context));
                        await login(context, widget.onlogin);
                        // widget.onlogin();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: InkWell(
                      onTap: () {
                        guest = true;
                        widget.onlogin();
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) =>
//                                      SignUpPage(widget.onlogin)));
                      },
                      child: Text(
                        'Continue as Guest',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // return Text("loading");
  // },
  // );
  // }
}
