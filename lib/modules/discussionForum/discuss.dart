import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/discussionForum/screens/home_screen.dart';
//package:IITDAPP/modules/discussionForum/
//void main() => runApp(MyNewApp());

class MyNewApp extends StatelessWidget {
  static const String routeName = '/discussionForum';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.teal,
      ),
      home: HomeScreen(),
    );
  }
}
