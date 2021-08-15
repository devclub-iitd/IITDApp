import 'package:IITDAPP/modules/attendance/EmptyScreen.dart';
import 'package:IITDAPP/modules/calendar/calendar.dart';
import 'package:IITDAPP/modules/dashboard/dashboard.dart';
import 'package:IITDAPP/modules/discussionForum/discuss.dart';
import 'package:IITDAPP/modules/events/home.dart';
import 'package:IITDAPP/modules/explore/explore.dart';
import 'package:IITDAPP/modules/login/LoginScreen.dart';
import 'package:IITDAPP/modules/login/RequestLoginScreen.dart';
import 'package:IITDAPP/modules/news/news.dart';
import 'package:IITDAPP/modules/quickLinks/quickLinks.dart';
import 'package:IITDAPP/modules/map/map.dart';
import 'package:IITDAPP/modules/settings/SettingsScreen.dart';
import 'package:IITDAPP/routes/Routes.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/courses/courses.dart';
import 'package:IITDAPP/modules/user-search/user.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (currentUser == null) {
      switch (settings.name) {
        case Routes.dashboard:
        case Routes.news:
        case Routes.events:
        case Routes.calendar:
          return _createRoute(RequestLoginScreen(
              settings.name[1].toUpperCase() + settings.name.substring(2)));
        case Routes.attendance:
          return _createRoute(EmptyScreen(
            title: 'Attendance',
            message: 'Coming Soon!',
            tag: 'Attendance',
          ));
        case Routes.explore:
          return _createRoute(Explore());
        case Routes.map:
          return _createRoute(Map());
        case Routes.discussionForum:
          return _createRoute(MyNewApp());
        case Routes.quickLinks:
          return _createRoute(QuickLinks());
        case Routes.reqLogin:
          return _createRoute(RequestLoginScreen(settings.arguments));
        case Routes.loginPage:
          return _createRoute(LoginScreen());
        case Routes.settingsPage:
          return _createRoute(SettingsScreen());
        case Routes.coursesPage:
          return _createRoute(CoursesScreen());
        case Routes.search:
          return _createRoute(SearchScreen());
        default:
          return MaterialPageRoute(
              builder: (_) => Scaffold(
                    body: Center(
                        child: Text('No route defined for ${settings.name}')),
                  ));
      }
    }
    switch (settings.name) {
      case Routes.dashboard:
        return _createRoute(Dashboard());
      case Routes.attendance:
        return _createRoute(EmptyScreen(
          title: 'Attendance',
          message: 'Coming Soon!',
          tag: 'Attendance',
        ));
      case Routes.explore:
        return _createRoute(Explore());
      case Routes.map:
        return _createRoute(Map());
      case Routes.discussionForum:
        return _createRoute(MyNewApp());
      case Routes.quickLinks:
        return _createRoute(QuickLinks());
      case Routes.news:
        return _createRoute(News());
      case Routes.calendar:
        return _createRoute(CalendarScreen());
      case Routes.events:
        return _createRoute(HomeScreen());
      case Routes.reqLogin:
        return _createRoute(RequestLoginScreen(settings.arguments));
      case Routes.loginPage:
        return _createRoute(LoginScreen());
      case Routes.settingsPage:
        return _createRoute(SettingsScreen());
      case Routes.coursesPage:
        return _createRoute(CoursesScreen());
      case Routes.search:
        return _createRoute(SearchScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  static Route _createRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
//        var begin = Offset(1.0, 0.0);
//        var end = Offset.zero;
//        var curve = Curves.ease;
//
//        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return FadeTransition(
//          position: animation.drive(tween),
          opacity: animation, //animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
