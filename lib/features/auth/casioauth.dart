// import 'dart:convert';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:http/http.dart' as http;
// import 'package:jose/jose.dart';

// class CasiUser {
//   String username;
//   String firstname;
//   String lastname;
//   String email;
//   List<String> roles;

//   CasiUser({
//     required this.email,
//     required this.firstname,
//     required this.lastname,
//     required this.roles,
//     required this.username,
//   });

//   factory CasiUser.fromJson(Map<String, dynamic> user) {
//     return CasiUser(
//       email: user['email'],
//       firstname: user['firstname'],
//       lastname: user['lastname'],
//       roles: (user['roles'] as List).map((e) => e.toString()).toList(),
//       username: user['username'],
//     );
//   }
// }

// class CasiLogin {
//   String? clientId;
//   String? secret;
//   final String _serverUrl = 'https://auth.devclub.in';
//   String? _loginURL;
//   String? _token;
//   Function(String token, CasiUser user)? _onSuccess =
//       (String token, CasiUser user) => {};
//   Function(dynamic err)? _onError = (dynamic err) => {};
//   Map<String, dynamic>? _cookies;

//   CasiLogin(String clientId, String accessToken,
//       {Function(String token, CasiUser user)? onSuccess,
//       Function(dynamic err)? onError}) {
//     _onSuccess = onSuccess;
//     _onError = onError;

//     final claims = {
//       'exp': DateTime.now()
//               .add(const Duration(minutes: 5))
//               .millisecondsSinceEpoch ~/
//           1000,
//       'data': {'clientId': clientId}
//     };
//     final builder = JsonWebSignatureBuilder()
//       ..jsonContent = claims
//       ..setProtectedHeader('alg', 'HS256')
//       ..addRecipient(JsonWebKey.fromJson({'kty': 'oct', 'k': accessToken}));

//     final signedToken = builder.build().toCompactSerialization();
//     secret = signedToken.toString();

//     _loginURL =
//         '$_serverUrl/user/login?serviceURL=$_serverUrl/auth/clientVerify?q=${Uri.encodeQueryComponent(secret!)}';
//   }

//   CasiLogin.fromToken(String token) {
//     _token = token;
//   }

//   Future<void> signIn() async {
//     // await launchUrl(Uri.parse(_loginURL!));

//     final webview = FlutterWebviewPlugin();
//     webview.onBack.listen((_) {
//       webview.close();
//     });
//     webview.onStateChanged.listen((state) {
//       if (state.type == WebViewState.finishLoad) {
//         if (state.url.startsWith('$_serverUrl/user/login')) {
//           webview
//               .evalJavascript('document.querySelector("#iitdLogin").click()');
//         }
//       }
//     });

//     webview.onUrlChanged.listen((url) async {
//       if (url.startsWith('$_serverUrl/auth/clientVerify?q=')) {
//         if (_token != null) return;
//         _token = 'mutex';
//         try {
//           _cookies = await webview.getCookies();
//           _token = _cookies!['"_rememberme'].toString();
//           _token = _token!.trim().substring(0, _token!.length - 1);
//           var user = await fetchUserDetails();
//           _onSuccess!(_token!, user);
//         } catch (e) {
//           _onError!('Login Failed');
//         }
//         await webview.close();
//       }
//     });
//     _token = null;
//     await webview.launch(
//       _loginURL!,
//       ignoreSSLErrors: true,
//       clearCookies: true,
//       clearCache: true,
//       userAgent:
//           'Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19',
//     );
//   }

//   Future<CasiUser> fetchUserDetails() async {
//     final response =
//         await http.post(Uri.parse('$_serverUrl/profile'), headers: {
//       'Cookie': 'rememberme=$_token;',
//     });
//     final jsonData = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       return CasiUser.fromJson(jsonData['user']);
//     } else {
//       throw Exception(jsonData['msg']);
//     }
//   }

//   Future<CasiUser> refreshToken(
//       {required String oldToken,
//       required Function(String token) onRefreshSuccess}) async {
//     var toSendToken = oldToken;
//     final response = await http.post(
//         Uri.parse('$_serverUrl/auth/refresh-token'),
//         body: {'rememberme': toSendToken});
//     final jsonData = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       onRefreshSuccess(
//           response.headers['set-cookie']!.split(';')[0].split('=')[1]);
//       return CasiUser.fromJson(jsonData['user']);
//     } else {
//       throw Exception(jsonData['msg']);
//     }
//   }
// }
