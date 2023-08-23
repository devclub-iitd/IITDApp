import 'package:flutter/material.dart';
import 'package:iitd_app/features/auth/pages/loginpage.dart';
import 'package:iitd_app/features/auth/pages/splashscreen.dart';
import 'package:iitd_app/features/events/pages/eventspage.dart';
import 'package:iitd_app/features/explore/pages/explorepage.dart';
import 'package:iitd_app/features/lostandfound/pages/lostandfoundpage.dart';
import 'package:iitd_app/features/news/pages/newspage.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String events = '/events';
  static const String lostandFound = '/lostandfound';
  static const String explore = '/explore';
  static const String news = '/news';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginPage(),
    events: (context) => const EventPage(),
    lostandFound: (context) => const LostAndFoundPage(),
    explore: (context) => const ExploreScreen(),
    news: (context) => const NewsPage(),
  };
}
