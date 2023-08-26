// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class AuthState extends ChangeNotifier {
//   bool _signedIn = false;
//   bool _loading = true;

//   bool get signedIn => _signedIn;
//   bool get loading => _loading;

//   void signIn() {
//     _signedIn = true;
//     _loading = false;

//     notifyListeners();
//   }

//   Future<void> checklogin(BuildContext context) async {
//     const storage = FlutterSecureStorage();
//     var tempToken = await storage.read(key: 'token');
//     if (tempToken == null) {
//       _loading = false;
//       notifyListeners();
//       return;
//     } else {
//       //await login(context);
//     }
//   }

// }