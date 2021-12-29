import 'package:IITDAPP/modules/events/events/event_info/update_calendar.dart';
import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/screens/newsPage.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'modules/events/events/event_info/event_info_screen.dart';

handleEventNotificationClick(id) {
  updateCalendar();
  navigatorKey.currentState.pushReplacement(MaterialPageRoute(
      builder: (context) => EventInfo(
            id,
          )));
}

handleNewsNotificationClick(id) async {
  var res = await apiBaseHelper.get('$uri/api/news/$id') as Map;
  var data = NewsModel.fromMap(res);
  // Fix the TabData, Possibly load all news items, search for the id,
  // and then load the page
  print('News Data is Here ${data.toJson()}');
  navigatorKey.currentState.pushReplacement(
    MaterialPageRoute(
      builder: (_) => NewsPage(
        item: data,
        imageTag: 't$id',
        redirectPossible: true,
      ),
    ),
  );
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
      token = await _firebaseMessaging.getToken();
      print('FirebaseMessaging token: $token');
      _initialized = true;
      // return token;
    }

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      print('YOYO Initial Message $message');
      if (message != null) {
        print('${message.data}');
        if (message.data['screen'] == 'event') {
          handleEventNotificationClick(message.data['id']);
        } else if (message.data['screen'] == 'news') {
          handleNewsNotificationClick(message.data['id']);
        }
        // print('A new message was published! ${message.data}');
        // Navigator.pushReplacementNamed(context, Routes.events);
      }
    });

    void _handleMessage(RemoteMessage message) {
      print('Baack Message: ${message.data}');
      // Navigator.pushReplacementNamed(context, Routes.events);
      if (message.data['screen'] == 'event') {
        handleEventNotificationClick(message.data['id']);
      } else if (message.data['screen'] == 'news') {
        handleNewsNotificationClick(message.data['id']);
      }
    }

    Future onSelectNotification(String payload) async {
      print(payload);
      if (payload == '') {
        return;
      }
      var screen_id = payload.split("/");
      print('First ${screen_id[0]}, second ${screen_id[1]}');
      if (screen_id[0] == 'event') {
        handleEventNotificationClick(screen_id[1]);
      } else if (screen_id[0] == 'news') {
        handleNewsNotificationClick(screen_id[1]);
      }
    }

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher_one'),
            iOS: IOSInitializationSettings());
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen(receivedMessage);

    return token;
    // "notoken";
  }
}
