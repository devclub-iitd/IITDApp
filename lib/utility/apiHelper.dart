import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  Future<dynamic> patch(String url,dynamic body) async {
    var responseJson;
    try {
      final response = await http.patch(url, headers: {'authorization': 'Bearer $token'},body: body).timeout(Duration(seconds: 10));
      responseJson = _returnResponse(response);
      print('called $url');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Connection tiimed out');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var responseJson;
    try {
      final response = await http.delete(url, headers: {'authorization': 'Bearer $token'},).timeout(Duration(seconds: 10));
      responseJson = _returnResponse(response);
      print('called $url');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Connection tiimed out');
    }
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(url, headers: {'authorization': 'Bearer $token'},).timeout(Duration(seconds: 10));
      responseJson = _returnResponse(response);
      print('called $url');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Connection tiimed out');
    }
    return responseJson;
  }

  Future<dynamic> post(String url,dynamic body) async {
    var responseJson;
    try {
      final response = await http.post(url, headers: {'authorization': 'Bearer $token'},body: body).timeout(Duration(seconds: 10));
      responseJson = _returnResponse(response);
      print('called $url');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Connection timed out');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 500:
      throw FetchDataException(json.decode(response.body.toString())['errors']['message']);
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
