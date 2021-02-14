import 'package:IITDAPP/modules/login/userlogin/login_page.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginStateProvider extends ChangeNotifier {
  bool _signedIn = false;
  bool _loading = true;

  bool get signedIn => _signedIn;
  bool get loading => _loading;

  void signIn() {
    _signedIn = true;
    _loading = false;

    notifyListeners();
  }

  Future<void> signOut() async {
    _signedIn = false;
    print('logged out');
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'email');
    await storage.delete(key: 'password');
    await storage.delete(key: 'token');
    // storage.deleteAll();
    token = null;
    currentUser = null;
    var ls = LocalStorage('iitapp');
    await ls.clear();
    // await deleteSharedPrefs();
    var prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
  }

  Future<void> checklogin(BuildContext context) async {
    print('Checking login');
    final storage = FlutterSecureStorage();
    var tempToken = await storage.read(key: 'token');
    if (tempToken == null) {
      print('Not logged in');
      _loading = false;

      notifyListeners();
      return;
    } else {
      print('already logged in');
      await login(context);
    }
  }
}
