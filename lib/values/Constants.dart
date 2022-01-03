/*import 'package:IITDAPP/modules/attendance/attendance.dart';
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

 //const String url = '172.27.20.227:5000';
 //const String url = 'http://192.168.43.251:5000';
//const String url = 'http://192.168.180.77:5000';
 //const String url = 'https://campusserver2.herokuapp.com/';
const String url= 'https://iitd-connect-server.herokuapp.com';
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
}*/
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math';

// const String url = '172.27.20.227:5000';
// const String url = 'http://192.168.43.251:5000';
// const String url = 'http://192.168.180.77:5000';
// const String url = 'https://campusserver2.herokuapp.com/';
// const String uri = 'https://iitd-connect-server.herokuapp.com';
const String uri = 'https://iitdconnect-server.devclub.in';

// ignore: always_declare_return_types
// PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
//   String appName = packageInfo.appName;
//   String packageName = packageInfo.packageName;
//   String version = packageInfo.version;
//   String buildNumber = packageInfo.buildNumber;
// });

String appName;
String packageName;
String version;
String buildNumber;

String title = 'IITD APP';
String token;
bool connectedToInternet = true;
User currentUser;
// User currentUser =
//     User(isAdmin: true, name: 'Va', email: 'cs1200374@iitd.ac.in');
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
var logoutFunc;
var loginFunc;
bool guest = false;

String defaultImage =
    'https://www.esm.rochester.edu/uploads/NoPhotoAvailable-500x625.jpg';

ApiBaseHelper apiBaseHelper = ApiBaseHelper();
var defaultScreen = 'Dashboard';
var rng = Random();
int randomNumber = rng.nextInt(5);
var xyz = 'assets/avatars/mikasa.jpeg';

void RNG(var randomNumber) {
  print("okok");
  if (randomNumber == 0) {
    xyz = 'assets/avatars/mikasa.jpeg';
  }
  if (randomNumber == 1) {
    xyz = 'assets/avatars/mikasa.jpeg';
  }
  if (randomNumber == 2) {
    xyz = 'assets/avatars/spiderman.png';
  }
  if (randomNumber == 3) {
    xyz = 'assets/avatars/ninja.png';
  }
  if (randomNumber == 4) {
    xyz = 'assets/avatars/panda.jpg';
  }
}

var avatars = {
  // 'anime': xyz,
  'origami': 'assets/images/origami3.png',
  'man': 'assets/avatars/man2.jpg',
  'woman': 'assets/avatars/woman2.png',
  'scenery': 'assets/images/scenery.png',
  'dog': 'assets/avatars/dog.jpg',
  'cat': 'assets/avatars/cat.jpg',
  'ninja': 'assets/avatars/ninja.png',
  'panda': 'assets/avatars/panda.jpg',
  'spiderman': 'assets/avatars/spiderman.png',
//   'gojo': 'assets/avatars/gojo.jpg',
  'mikasa': 'assets/avatars/mikasa.jpeg',
};
var avImage = avatars['origami'];

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

var backgroundimages = {
//   'peachtree': 'assets/bg/5.jpg',
  'beach': 'assets/bg/1.jpg',
  'IITD': 'assets/bg/2.jpeg',
  'nightsky': 'assets/bg/nightsky2.jpg',
  'castle': 'assets/bg/castle.jpg',
  'sunset': 'assets/bg/3.jpg',
  'peachtree': 'assets/bg/5.jpg',
  'earth': 'assets/bg/earth.jpg',
  'city': 'assets/bg/city.jpg',
  'abstract': 'assets/bg/abstract.jpg',
  'scenery': 'assets/bg/scenery.jpg',
  'dojo': 'assets/bg/dojo.jpg',
};

var bgimage = backgroundimages['IITD'];

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
