import 'package:IITDAPP/modules/dashboard/dashboard.dart';
// import 'package:IITDAPP/modules/events/home.dart';
import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:IITDAPP/widgets/error_alert.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:localstorage/localstorage.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'userlogin/login_page.dart';


class LoginScreen extends StatefulWidget {

  static const String routeName = '/login';

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
//  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool signedIn;
  bool start;

  void onlogin() {
    print('logged in');
    setState(() {
      signedIn = true;
    });
  }

  void deleteSharedPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void onlogout() {
    print('logged out');
    final storage = FlutterSecureStorage();
    storage.deleteAll();
    var ls = LocalStorage('iitapp');
    ls.clear();
    deleteSharedPrefs();
    setState(() {
      signedIn = false;
    });
  }

  Future checklogin() async {
    print('Checking login');
    final storage = FlutterSecureStorage();
    // ignore: omit_local_variable_types
    final LocalStorage localStorage = LocalStorage('iitdapp');
    var tempEmail = await storage.read(key: 'email');
    var tempPass = await storage.read(key: 'password');
    print('Saved email: $tempEmail');
    if (tempEmail == null) {
      print('Not logged in');
      return;
    } else {
      var flag = false;
      final loginresponse = await http.post('$url/api/login',
          body: {'email': tempEmail, 'password': tempPass}).timeout(
        Duration(seconds: 5),
        onTimeout: () async {
          flag = true;
          print('Cannot connect to iternet');
          token = await storage.read(key: 'token');
          var parsedJson = await localStorage.getItem('currentUser');
          currentUser = User.fromJson(parsedJson['data']);
          if(token==null || currentUser==null) {
            print('Check your internet connection and try aagin');
          }else {
            signedIn = true;
          }
          return null;
        },
      );
      connectedToInternet = !flag;
      if(flag) {
        return;
      }
      if (loginresponse.statusCode == 200) {
        var parsedJson = json.decode(loginresponse.body);
        token = parsedJson['data']['token'];
        await storage.write(key: 'token', value: token);
      } else {
        showErrorAlert(context, 'Session Expired', "Please Login Again");
        return;
      }
      print('already logged in');
      signedIn = true;
      final response = await http
          .get('$url/api/user/me', headers: {'authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        // print(response.body);
        var parsedJson = json.decode(response.body);
        currentUser = User.fromJson(parsedJson['data']);
        await localStorage.setItem('currentUser', parsedJson);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print('startup');
    loginFunc = onlogin;
    logoutFunc = onlogout;
    start = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (start == true)
            ? FutureBuilder(
          future: checklogin(),
          builder: (context, snapshot) {
            start = false;
            if (snapshot.connectionState == ConnectionState.done) {
              Widget home;
              if (signedIn == true) {
                home = Dashboard();
              } else {
                home = LoginPage(onlogin: onlogin);
              }
              return home;
            }
            return Scaffold(
              backgroundColor: Colors.indigo[600],
              drawer: AppDrawer(
                tag: 'Events',
              ),
              body: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'by DevClub',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
            : (signedIn == true)
            ? Dashboard()
            : LoginPage(onlogin: onlogin));
  }
}
