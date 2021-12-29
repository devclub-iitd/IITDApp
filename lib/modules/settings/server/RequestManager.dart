import 'package:IITDAPP/values/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<bool> changeEventsNotificationState(bool state) async {
  // Send Request
  var response = await http
      .post('$uri/api/events/toggle-subscribe-event-notification/',
          headers: {
            'authorization': 'Bearer $token',
            "Content-Type": "application/json"
          },
          body: jsonEncode({'eventNotifications': state}))
      .timeout(const Duration(seconds: 5));
  if (response.statusCode != 200) {
    return false;
  }
  return state == json.decode(response.body)['data']['eventNotifications'];
}

Future<bool> changeNewsNotificationState(bool state) async {
  // Send Request
  var response = await http
      .post('$uri/api/news/toggle-subscribe-news-notification/',
          headers: {
            'authorization': 'Bearer $token',
            "Content-Type": "application/json"
          },
          body: jsonEncode({'newsNotifications': state}))
      .timeout(const Duration(seconds: 5));
  if (response.statusCode != 200) {
    return false;
  }
  return state == json.decode(response.body)['data']['newsNotifications'];
}
