// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:IITDAPP/values/Constants.dart';
import 'package:http/http.dart' as http;
// import 'package:IITDAPP/routes/Routes.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:math';
import 'package:IITDAPP/main.dart';

// var stream =
//         http.ByteStream(DelegatingStream.typed(_event.eventImage.openRead()));
//     var length = await _event.eventImage.length();
//     String goto = '$uri/api/events/${_event.eventid}';
//     print(goto);
//     var request = http.MultipartRequest("PUT", Uri.parse(goto));
//     var multipartFile = http.MultipartFile('eventImage', stream, length,
//         filename: basename(_event.eventImage.path));
//     request.files.add(multipartFile);

//     request.fields['name'] = _event.eventName;
//     request.fields['about'] = _event.about;
//     request.fields['startDate'] = _event.startsAt.toIso8601String();
//     request.fields['endDate'] = _event.endsAt.toIso8601String();
//     request.fields['venue'] = _event.venue;
//     // request.fields['eventImage'] = base64image;
//     request.headers['authorization'] = 'Bearer $token';

//     final response = await request.send();
//     print(response.statusCode);
//     response.stream.transform(utf8.decoder).listen((value) {
//       print(value);
//     });
//     if (response.statusCode == 200) {
//       await Provider.of<EventsTabProvider>(this.context, listen: false)
//           .getData();
//       Navigator.pop(this.context);
//     } else {
//       Navigator.pop(this.context);
//       await showErrorAlert(
//           this.context, 'Failed', 'Something went wrong. Please try again');
//     }
class ApiBaseHelper {
  Future<dynamic> put(String url, dynamic body, File newsImage) async {
    var responseJson;
    try {
      // final response = await http
      //     .put(url, headers: {'authorization': 'Bearer $token'}, body: body)
      //     .timeout(Duration(seconds: 10));

      // print(body);
      String temp;
      if (newsImage == null) {
        var bytes = await rootBundle.load('assets/images/null.png');
        temp = (await getTemporaryDirectory()).path;
        newsImage = File('$temp/img.png');
        tempo.add(newsImage.path);
        await newsImage.writeAsBytes(
            bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
      }
      var stream =
          http.ByteStream(DelegatingStream.typed(newsImage.openRead()));
      var length = await newsImage.length();
      var request = http.MultipartRequest("PUT", Uri.parse(url));
      var multipartFile = http.MultipartFile('newsImage', stream, length,
          filename: basename(newsImage.path));
      request.files.add(multipartFile);
      request.fields['author'] = body['author'];
      request.fields['content'] = body['content'];
      request.fields['title'] = body['title'];
      request.fields['sourceName'] = body['sourceName'];
      request.headers['authorization'] = 'Bearer $token';
      request.fields['imgUrl'] = body['imgUrl'];

      final response = await request.send();
      print('put called $url');
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
      print('call done');
      // responseJson = _returnResponse(response);

      clear();
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Connection timed out');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var responseJson;
    try {
      final response = await http.post(
        url,
        headers: {'authorization': 'Bearer $token'},
      ).timeout(Duration(seconds: 10));
      responseJson = _returnResponse2(response);
      print('delete called $url');
      print(json.decode(response.body.toString()));
      print('done delete');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Connection timed out');
    }
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(
        url,
        headers: {'authorization': 'Bearer $token'},
      ).timeout(Duration(seconds: 10));
      responseJson = _returnResponse2(response);
      print('get called $url');
      print(json.decode(response.body.toString()));
      print('done get');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Connection timed out');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body, File newsImage) async {
    var responseJson;
    try {
      // final response = await http
      //     .post(url, headers: {'authorization': 'Bearer $token'}, body: body)
      //     .timeout(Duration(seconds: 10));
      // responseJson = _returnResponse(response);

      // print(body);
      String temp;
      if (newsImage == null) {
        var ok = Random();
        var bytes = await rootBundle.load('assets/images/null.png');
        temp = (await getTemporaryDirectory()).path;
        newsImage = File('$temp/img' +
            ok.nextInt(2000).toString() +
            ok.nextInt(2000).toString() +
            ok.nextInt(2000).toString() +
            '.png');
        tempo.add(newsImage.path);
        await newsImage.writeAsBytes(
            bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
      }
      var stream =
          http.ByteStream(DelegatingStream.typed(newsImage.openRead()));
      var length = await newsImage.length();
      var request = http.MultipartRequest("POST", Uri.parse(url));
      var multipartFile = http.MultipartFile('newsImage', stream, length,
          filename: basename(newsImage.path));
      request.files.add(multipartFile);
      request.fields['author'] = body['author'];
      request.fields['content'] = body['content'];
      request.fields['title'] = body['title'];
      request.fields['sourceName'] = body['sourceName'];
      request.fields['imgUrl'] = '';
      request.headers['authorization'] = 'Bearer $token';

      print('post called $url');
      final response = await request.send();
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
      print('done post');
      // responseJson = _returnResponse(response);

      clear();
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Connection timed out');
    }
    return responseJson;
  }

//   dynamic _returnResponse(http.StreamedResponse response) async {
//     switch (response.statusCode) {
//       case 200:
//         var responseJson = response.stream.bytesToString().toString();
//         return responseJson;
//       case 500:
//         throw FetchDataException(
//             // response.stream.bytesToString()['errors']['message']);
//             await response.stream.bytesToString());
//       default:
//         throw FetchDataException(
//             'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
//     }
//   }

  dynamic _returnResponse2(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 500:
        throw FetchDataException(
            // response.stream.bytesToString()['errors']['message']);
            json.decode(response.body.toString())['errors']['message']);
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
