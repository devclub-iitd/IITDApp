import 'package:IITDAPP/modules/login/user_class.dart';
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