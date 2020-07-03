import 'package:IITDAPP/modules/attendance/data/attendanceProvider.dart';
import 'package:IITDAPP/utility/apiResponse.dart';
import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/attendance/widgets/headings/attendanceListHeader.dart';
import 'package:IITDAPP/modules/attendance/widgets/cards/courseCard.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/modules/news/widgets/shimmers/sizedShimmer.dart';

class AttendanceList extends StatefulWidget {
  final entryNumber;
  const AttendanceList(
    this.entryNumber, {
    Key key,
  }) : super(key: key);

  @override
  _AttendanceListState createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  @override
  Widget build(BuildContext context) {
    Provider.of<AttendanceProvider>(context, listen: false)
        .setEntryNumber(widget.entryNumber);
    // print('built AttendanceList');
    final loadingShimmer = SizedShimmer(
      baseColor:
          Provider.of<ThemeModel>(context).theme.COURSE_CARD.withAlpha(100),
      highlightColor:
          Provider.of<ThemeModel>(context).theme.COURSE_CARD.withAlpha(200),
      height: 75,
    );
    return Stack(
      children: <Widget>[
        Consumer<AttendanceProvider>(builder: (_, ap, c) {
          if (ap.data.status == Status.LOADING) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AttendanceListHeader('Poor'),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                      child: loadingShimmer,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                      child: loadingShimmer,
                    ),
                    AttendanceListHeader('Regular'),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                      child: loadingShimmer,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                      child: loadingShimmer,
                    ),
                  ]),
            );
          } else if (ap.data.status == Status.ERROR) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Error: ${ap.data.message}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Provider.of<ThemeModel>(context)
                          .theme
                          .PRIMARY_COLOR_LIGHT),
                ),
                FlatButton(
                  onPressed: () {
                    ap.fetchData();
                  },
                  child: Text('REFRESH'),
                  textColor:
                      Provider.of<ThemeModel>(context).theme.PRIMARY_COLOR_DARK,
                  color: Provider.of<ThemeModel>(context).theme.PRIMARY_COLOR,
                )
              ],
            );
          } else {
            var children = <Widget>[];
            var regular = ap.data.data.where((f) =>
                (f.daysPresent) / (f.daysAbsent + f.daysPresent) >= 0.75);
            var poor = ap.data.data.where(
                (f) => (f.daysPresent) / (f.daysAbsent + f.daysPresent) < 0.75);
            if (poor.isNotEmpty) {
              children.add(AttendanceListHeader('Poor'));
              children.addAll(poor.map((i) => CourseCard(i)));
            }
            if (regular.isNotEmpty) {
              children.add(AttendanceListHeader('Regular'));
              children.addAll(regular.map((i) => CourseCard(i)));
            }
            return RefreshIndicator(
              color: Provider.of<ThemeModel>(context).theme.COURSE_CARD,
              onRefresh: () {
                return ap.fetchData();
              },
              child: ListView(
                children: children,
              ),
            );
          }
        }),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            color: Colors.blueGrey.withOpacity(0.3),
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Disclaimer : This information may be inaccurate.',
                    style: TextStyle(
                      color: Provider.of<ThemeModel>(context)
                          .theme
                          .PRIMARY_TEXT_COLOR
                          .withOpacity(0.3),
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
