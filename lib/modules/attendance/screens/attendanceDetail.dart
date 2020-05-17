import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/attendance/data/attendanceModel.dart';
import 'package:IITDAPP/modules/attendance/widgets/cards/daysCard.dart';
import 'package:IITDAPP/modules/attendance/widgets/headings/coursePageHeader.dart';
import 'package:IITDAPP/values/colors/colors.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/modules/attendance/widgets/attendanceCalendar.dart';

class AttendanceDetail extends StatelessWidget {
  final AttendanceModel _am;
  const AttendanceDetail(this._am);
  @override
  Widget build(BuildContext context) {
    // print('built AttendanceDetail');
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Attendance'),
        withMenu: false,
      ),
      backgroundColor: AppColors.PRIMARY_COLOR_DARK,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CoursePageHeader(_am.name, _am.abbr),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DaysCard(_am.daysPresent, 'Present', false),
              DaysCard(_am.daysAbsent, 'Absent', false),
              DaysCard(_am.daysPresent + _am.daysAbsent, 'Total', true),
            ],
          ),
          AttendanceCalendar(_am.presentDates),
        ],
      ),
    );
  }
}
