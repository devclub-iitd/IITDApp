// import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/courses/calendar/acadCalendarGenerator.dart';
import 'package:IITDAPP/modules/courses/courses.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
// import 'package:IITDAPP/routes/Routes.dart';
// import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomCard extends StatefulWidget {
  CustomCard(this.callback);
  var callback;
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  // Check if xx is a digit

  @override
  Widget build(BuildContext context) {
    var sem = '';
    if (currentUser.email.length > 5) {
      if (currentUser.email.substring(3, 5) == "21" &&
          isNumeric(currentUser.email.substring(2, 3))) {
        sem = "1";
      } else {
        sem = "2";
      }
    }
    const height = 600.0;
    return Scaffold(
        backgroundColor: Colors.transparent,
        // Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () async {},
          backgroundColor: Colors.greenAccent,
          child: IconButton(
            onPressed: () async {
              print(widget.toString());
              await generate_calendar_(currentUser.tocalender);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Calendar Generated'),
                duration: Duration(seconds: 3),
              ));
              widget.callback();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: FaIcon(
              FontAwesomeIcons.fileExport,
              // Icons.share,
              size: 25,
            ),
          ),
        ),
        body: Container(
          height: height, // change this
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(height / 20)),
            color: Provider.of<ThemeModel>(context)
                .theme
                .COURSE_CARD
                .withOpacity(1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(height: 10),
              Text(
                'Courses',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
              ),
              Container(height: 10),
              Text(
                '2021-22 Sem $sem',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Container(height: 8),
              Divider(
                color: Colors.grey,
              ),
              Container(
                  height: 360,
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowGlow();
                      return;
                    },
                    child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ...currentUser.tocalender
                                .map((e) => UserCourse(e))
                                .toList(),
                          ],
                        )),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Spacer(),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: TextButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent),
                        ),
                        onPressed: () => {
                              Navigator.pop(context),
                              // Navigator.pushNamed(context, Routes.coursesPage),
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          CoursesScreen()))
                            },
                        child: Text("Back")),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
