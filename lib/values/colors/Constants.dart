import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/utility/apiHelper.dart';
import 'package:flutter/material.dart';

const String url = 'http://192.168.43.81:5000';
String title = 'IITD APP';
String token;
bool connectedToInternet = true;
User currentUser;
// User currentUser = User(isAdmin: true,name: 'Prakhar Jagwani',email: 'cs1190382@iitd.ac.in');
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
var logoutFunc;
var loginFunc;
bool guest = false;

String defaultImage ='https://www.esm.rochester.edu/uploads/NoPhotoAvailable-500x625.jpg';

ApiBaseHelper apiBaseHelper = ApiBaseHelper();