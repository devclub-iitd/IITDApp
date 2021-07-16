import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/attendance/data/attendanceModel.dart';
import 'package:IITDAPP/modules/attendance/screens/attendanceDetail.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/routes/Transitions.dart';

class CourseCard extends StatelessWidget {
  final AttendanceModel _am;
  const CourseCard(this._am, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _percentage =
        (100 * _am.daysPresent / (_am.daysPresent + _am.daysAbsent)).round();
    // print('built course card');
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
      color: Provider.of<ThemeModel>(context).theme.COURSE_CARD,
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            title: Hero(
              tag: _am.abbr,
              child: Container(
                child: Text(
                  _am.name,
                  style: Theme.of(context).primaryTextTheme.bodyText1.apply(
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .PRIMARY_TEXT_COLOR,
                        fontSizeFactor: 1.15,
                        decoration: null,
                      ),
                ),
              ),
            ),
            subtitle: Text(
              _am.abbr,
              style: Theme.of(context).primaryTextTheme.bodyText2.apply(
                    color: Provider.of<ThemeModel>(context)
                        .theme
                        .PRIMARY_TEXT_COLOR
                        .withOpacity(0.5),
                    fontSizeFactor: 1,
                    decoration: null,
                  ),
            ),
            onTap: () {
              Navigator.push(context, FadeRoute(page: AttendanceDetail(_am)));
            },
            trailing: Container(
              width: 60,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 11),
                    width: 1,
                    decoration: BoxDecoration(
                      color: Provider.of<ThemeModel>(context)
                          .theme
                          .PRIMARY_TEXT_COLOR
                          .withOpacity(0.5),
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Text(
                            '$_percentage%',
                            style: TextStyle(
                                color: Provider.of<ThemeModel>(context,
                                        listen: false)
                                    .theme
                                    .PRIMARY_TEXT_COLOR,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'Present',
                          style: TextStyle(
                              color: Provider.of<ThemeModel>(context,
                                      listen: false)
                                  .theme
                                  .PRIMARY_TEXT_COLOR
                                  .withOpacity(0.5),
                              fontSize: 13),
                        )
                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
