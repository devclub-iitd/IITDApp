import 'package:IITDAPP/values/Constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'modules/events/events/event_info/event_info_screen.dart';

handleEventNotificationClick(context, id) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => EventInfo(id)));
}

handleNewsNotificationClick(context, id) {
  // Fix the TabData, Possibly load all news items, search for the id,
  // and then load the page
  // Navigator.pushReplacement(
  //   context,
  //   MaterialPageRoute(
  //     builder: (_) => NewsPage(
  //       item: tabData[i],
  //       imageTag: 't${tabData[i].id}',
  //       redirectPossible: true,
  //     ),
  //   ),
  // );
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.max,
);

void receivedMessage(RemoteMessage message) {
  print('YEP RECEIVED THE MESSAGE');
  RemoteNotification notification = message.notification;
  AndroidNotification android = message.notification?.android;
  var payload = "";
  if (message.data != null) {
    print(message.data);
    payload = "${message.data['screen']}/${message.data['id']}";
  }
  print(payload);

  // If `onMessage` is triggered with a notification, construct our own
  // local notification to show to users using the created channel.
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
          icon: android?.smallIcon,
          // other properties...
        ),
      ),
      payload: payload,
    );
  }
}

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;
  var token = "notoken";
  Future<String> init() async {
    if (!_initialized) {
      var token = await _firebaseMessaging.getToken();
      print('FirebaseMessaging token: $token');
      _initialized = true;
      // return token;
    }

    _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen(receivedMessage);

    return token;
    // "notoken";
  }
}
