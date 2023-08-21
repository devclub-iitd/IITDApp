import 'package:flutter/material.dart';
import 'package:iitd_app/auth/loginpage.dart';
import 'package:iitd_app/auth/splashscreen.dart';
import 'package:iitd_app/events/eventspage.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String events = '/events';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginPage(),
    events:(context) => const EventPage()
  };
}
