import 'package:flutter/material.dart';

import 'package:IITDAPP/values/colors/colors.dart';

class AttendanceListHeader extends StatelessWidget {
  final String text;
  const AttendanceListHeader(this.text);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Text(
          text,
          style: Theme.of(context).primaryTextTheme.bodyText2.apply(
                color: AppColors.ATTENDANCE_HEADING_LIGHT,
                fontSizeFactor: 1.2,
                fontWeightDelta: 2,
                decoration: null,
              ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 2.5),
        child: Container(
          height: 3,
          width: text == 'Poor' ? 40 : 60,
          margin: EdgeInsets.symmetric(vertical: 5),
          color: Colors.blue,
        ),
      )
    ]);
  }
}
