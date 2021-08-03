import 'package:IITDAPP/modules/attendance/attendance.dart';
import 'package:IITDAPP/modules/calendar/calendar.dart';
import 'package:IITDAPP/modules/dashboard/dashboard.dart';
import 'package:IITDAPP/modules/events/home.dart';
import 'package:IITDAPP/modules/explore/explore.dart';
import 'package:IITDAPP/modules/login/LoginScreen.dart';
import 'package:IITDAPP/modules/login/RequestLoginScreen.dart';
import 'package:IITDAPP/modules/map/map.dart';
import 'package:IITDAPP/modules/news/news.dart';
import 'package:IITDAPP/modules/quickLinks/quickLinks.dart';
import 'package:IITDAPP/modules/settings/SettingsScreen.dart';
import 'package:IITDAPP/modules/discussionForum/discuss.dart';
import 'package:IITDAPP/modules/courses/courses.dart';


class Routes {
  static const String dashboard = Dashboard.routeName;
  static const String attendance = Attendance.routeName;
  static const String explore = Explore.routeName;
  static const String map = Map.routeName;
  static const String news = News.routeName;
  static const String quickLinks = QuickLinks.routeName;
  static const String calendar = CalendarScreen.routeName;
  static const String events = HomeScreen.routeName;
  static const String reqLogin = RequestLoginScreen.routeName;
  static const String loginPage = LoginScreen.routeName;
  static const String settingsPage = SettingsScreen.routeName;
  static const String discussionForum = MyNewApp.routeName;
  static const String coursesPage = CoursesScreen.routeName;
}
