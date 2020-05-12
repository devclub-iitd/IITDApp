import 'package:IITDAPP/modules/attendance/attendance.dart';
import 'package:IITDAPP/modules/dashboard/dashboard.dart';
import 'package:IITDAPP/modules/explore/explore.dart';
import 'package:flutter/material.dart';
import './routes/Routes.dart';

void main() {

  runApp(
      MaterialApp(
        title: 'IITD APP',
        theme: ThemeData(
            primarySwatch: Colors.indigo
        ),
        home: Dashboard(),
        routes:  {
          Routes.dashboard: (context) => Dashboard(),
          Routes.attendance: (context) => Attendance(),
          Routes.explore: (context) => Explore(),

        },
      )
  );
}