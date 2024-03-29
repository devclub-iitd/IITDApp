

import 'package:flutter/material.dart';
import 'package:iitd_app/features/events/pages/addEvent.dart';
import 'package:iitd_app/features/events/pages/eventspage.dart';
import 'package:iitd_app/features/clubs/pages/clubspage.dart';
import 'package:iitd_app/features/hangouts/pages/hangoutspage.dart';
import 'package:iitd_app/features/liked/likedpage.dart';
import 'package:iitd_app/features/lostandfound/pages/lostandfoundpage.dart';
import 'package:iitd_app/features/news/pages/newspage.dart';
import 'package:iitd_app/features/quicklinks/quicklinkpage.dart';

class AppRoutes {
  // static const String splash = '/';
  // static const String login = '/login';
  static const String events = '/events';
  static const String addevent = '/addevent';
  static const String lostandFound = '/lostandfound';
  static const String clubs = '/clubs';
  static const String hangouts = '/hangouts';
  static const String news = '/news';
  static const String liked = '/liked';
  static const String links = '/quicklinks';

  static Map<String, WidgetBuilder> routes = {
    // splash: (context) => const SplashScreen(),
    // login: (context) => const LoginPage(),
    events: (context) => const EventPage(),
    addevent: (context) => const AddEventPage(),
    lostandFound: (context) => const LostAndFoundPage(),
    clubs: (context) => const ClubsPage(),
    hangouts: (context) => const HangoutsPage(),
    news: (context) => const NewsPage(),
    liked : (context) => const LikedPage(),
    links : (context) => const QuickLinks()
  };
}
