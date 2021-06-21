import 'dart:convert';
import 'package:corsac_jwt/corsac_jwt.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;

class CasiUser {
  String username;
  String firstname;
  String lastname;
  String email;
  String isverified;
  List<String> roles;

  CasiUser({
    this.email,
    this.firstname,
    this.isverified,
    this.lastname,
    this.roles,
    this.username,
  });

  factory CasiUser.fromJson(Map<String, dynamic> user) {
    return CasiUser(
      email: user['email'],
      firstname: user['firstname'] ?? '',
      lastname: user['lastname'] ?? '',
      roles: (user['roles'] as List).map((e) => e.toString()).toList() ?? [],
      username: user['username'] ?? '',
    );
  }
}

class CasiLogin {
  String clientId;
  String secret;
  final String _serverUrl = 'https://auth.devclub.in';
  String _loginURL;
  String _token;
  Function(String token, CasiUser user) _onSuccess =
      (String token, CasiUser user) => {};
  Function(dynamic err) _onError = (dynamic err) => {};
  Map<String, dynamic> _cookies;

  CasiLogin(String clientId, String accessToken,
      {Function(String token, CasiUser user) onSuccess,
      Function(dynamic err) onError}) {
    this.clientId = clientId;

    _onSuccess = onSuccess ?? _onSuccess;
    _onError = onError ?? _onError;

    var builder =  JWTBuilder();
    var signer =  JWTHmacSha256Signer(accessToken);
    builder
      ..expiresAt =  DateTime.now().add( Duration(minutes: 5))
      ..setClaim('data', {'clientId': clientId});

    var signedToken = builder.getSignedToken(signer);
    secret = signedToken.toString();

    _loginURL =
        '${_serverUrl}/user/login?serviceURL=${_serverUrl}/auth/clientVerify?q=${Uri.encodeQueryComponent(secret)}';
  }

  CasiLogin.fromToken(String token) {
    _token = token;
  }

  Future<void> signIn() async {
    if (_loginURL == null)
      {throw Exception('No client ID and client secret found');}
    final webview =  FlutterWebviewPlugin();
    webview.onUrlChanged.listen((url) async {
      print('URL CHANGED: $url');

      if (url.startsWith('${_serverUrl}/auth/clientVerify?q=')) {
        if (_token != null) return;
        _token = 'mutex';
        try {
          _cookies = await webview.getCookies();
          _token = _cookies['"_rememberme'].toString();
          _token = _token.trim().substring(0, _token.length - 1);
          var user = await fetchUserDetails();
          _onSuccess(_token, user);
        } catch (e) {
          _onError('Login Failed');
        }
        await webview.close();
      }
    });
    _token = null;
    await webview.launch(
      _loginURL,
      ignoreSSLErrors: true,
      clearCookies: true,
      clearCache: true,
      userAgent:
          'Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19',
    );
  }

  Future<CasiUser> fetchUserDetails() async {
    final response = await http.post(_serverUrl + '/profile', headers: {
      'Cookie': 'token=${_token};',
    });
    final jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return CasiUser.fromJson(jsonData['user']);
    } else {
      throw Exception(jsonData['msg']);
    }
  }

  Future<CasiUser> refreshToken(
      {String oldToken, Function(String token) onRefreshSuccess}) async {
    if (oldToken == null && _token == null) throw Exception('No token found');
    var toSendToken = oldToken ?? _token;

    final response = await http.post(_serverUrl + '/auth/refresh-token',
        body: {'token': toSendToken});
    final jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (onRefreshSuccess != null) {
        onRefreshSuccess(
            response.headers['set-cookie'].split(';')[0].split('=')[1]);
      }
      return CasiUser.fromJson(jsonData['user']);
    } else {
      throw Exception(jsonData['msg']);
    }
  }
}
