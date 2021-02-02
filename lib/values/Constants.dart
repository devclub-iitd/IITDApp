import 'package:IITDAPP/modules/attendance/attendance.dart';
import 'package:IITDAPP/modules/calendar/calendar.dart';
import 'package:IITDAPP/modules/dashboard/dashboard.dart';
import 'package:IITDAPP/modules/events/home.dart';
import 'package:IITDAPP/modules/explore/explore.dart';
import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/utility/apiHelper.dart';
import 'package:IITDAPP/modules/map/map.dart';
import 'package:IITDAPP/modules/news/news.dart';
import 'package:IITDAPP/modules/quickLinks/quickLinks.dart';
import 'package:flutter/material.dart';

const String url = 'http://10.0.2.2:5000';
// const String url = 'https://campusserver.herokuapp.com';
String title = 'IITD APP';
String token;
bool connectedToInternet = true;
User currentUser;
// User currentUser = User(isAdmin: true,name: 'Prakhar Jagwani',email: 'cs1190382@iitd.ac.in');
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
var logoutFunc;
var loginFunc;
bool guest = false;

String defaultImage =
    'https://www.esm.rochester.edu/uploads/NoPhotoAvailable-500x625.jpg';

ApiBaseHelper apiBaseHelper = ApiBaseHelper();
var defaultScreen = 'Dashboard';

Widget getScreenFromTag(var tag) {
  switch (tag) {
    case 'Dashboard':
      return Dashboard();
    case 'Events':
      return HomeScreen();
    case 'Calendar':
      return CalendarScreen();
    case 'News':
      return News();
    case 'Attendance':
      return Attendance();
    case 'Quick Links':
      return QuickLinks();
    case 'Explore':
      return Explore();
    case 'Map':
      return Map();
  }
  return null;
}
