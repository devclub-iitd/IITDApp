import 'package:IITDAPP/modules/dashboard/dashboard.dart';
import 'package:IITDAPP/routes/router.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(
      MaterialApp(
        title: 'IITD APP',
        theme: ThemeData(
            primarySwatch: Colors.indigo
        ),
        home: Dashboard(),
        onGenerateRoute: Router.generateRoute,
//        routes:  {
//          Routes.dashboard: (context) => Dashboard(),
//          Routes.attendance: (context) => Attendance(),
//          Routes.explore: (context) => Explore(),
//        },
      )
  );
}
