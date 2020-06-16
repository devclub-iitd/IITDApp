import 'package:IITDAPP/modules/attendance/attendance.dart';
import 'package:IITDAPP/modules/calendar/calendar.dart';
import 'package:IITDAPP/modules/dashboard/dashboard.dart';
import 'package:IITDAPP/modules/events/home.dart';
import 'package:IITDAPP/modules/explore/explore.dart';
import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/modules/map/map.dart';
import 'package:IITDAPP/modules/news/news.dart';
import 'package:IITDAPP/modules/quickLinks/quickLinks.dart';
import 'package:flutter/material.dart';

String url = 'http://192.168.43.251:5000';
String title = 'IITD APP';
String token;
bool connectedToInternet = true;
User currentUser;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
var logoutFunc;
var loginFunc;
bool guest = false;

var mainScreens = {
  'Dashboard': Dashboard,
  'Events': HomeScreen,
  'Calendar': CalendarScreen,
  'News': News,
  'Attendance': Attendance,
  'Quick Links': QuickLinks,
  'Explore': Explore,
  'Map': Map
};