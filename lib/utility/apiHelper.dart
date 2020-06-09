import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiBaseHelper {
  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(url).timeout(Duration(seconds: 10));
      responseJson = _returnResponse(response);
      print('called $url');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Connection tiimed out');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class FetchDataException implements Exception {
  final String _message;
  FetchDataException(this._message);

  @override
  String toString() {
    return _message;
  }
}
