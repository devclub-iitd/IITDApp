import 'dart:js';

import 'package:flutter/material.dart';
import 'package:iitd_app/features/auth/pages/loginpage.dart';
import 'package:iitd_app/features/auth/pages/splashscreen.dart';
import 'package:iitd_app/features/events/pages/eventspage.dart';
import 'package:iitd_app/features/lostandfound/pages/lostandfoundpage.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String events = '/events';
  static const String lostandFound = '/lostandfound';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginPage(),
    events: (context) => const EventPage(),
    lostandFound:(context)=> const LostAndFoundPage()
  };
}
