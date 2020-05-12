import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/attendance/screens/attendanceList.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:IITDAPP/values/colors/colors.dart';

class Attendance extends StatelessWidget {
  static const String routeName = '/attendance';
  final entryNumber = '2019CS11111';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Attendance'),
      ),
      backgroundColor: AppColors.PRIMARY_COLOR_DARK,
      drawer: AppDrawer(),
      body: AttendanceList(entryNumber),
    );
  }
}
