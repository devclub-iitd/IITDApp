import 'package:flutter/material.dart';
import 'package:iitd_app/features/events/pages/addEvent.dart';
import 'package:iitd_app/features/events/pages/eventspage.dart';
import 'package:iitd_app/features/clubs/pages/clubspage.dart';
import 'package:iitd_app/features/hangouts/pages/hangoutpage.dart';
import 'package:iitd_app/features/lostandfound/pages/lostandfoundpage.dart';
import 'package:iitd_app/features/news/pages/newspage.dart';

class AppRoutes {
  // static const String splash = '/';
  // static const String login = '/login';
  static const String events = '/events';
  static const String addevent = '/addevent';
  static const String lostandFound = '/lostandfound';
  static const String clubs = '/clubs';
  static const String hangouts = '/hangouts';
  static const String news = '/news';

  static Map<String, WidgetBuilder> routes = {
    // splash: (context) => const SplashScreen(),
    // login: (context) => const LoginPage(),
    events: (context) => const EventPage(),
    addevent: (context) => const AddEventPage(),
    lostandFound: (context) => const LostAndFoundPage(),
    clubs: (context) => const ClubsPage(),
    hangouts: (context) => const HangoutPage(),
    news: (context) => const NewsPage(),
  };
}
