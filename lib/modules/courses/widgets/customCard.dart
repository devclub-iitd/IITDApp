// import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/courses/courses.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/routes/Routes.dart';
// import 'package:provider/provider.dart';

class CustomCard extends StatefulWidget {
  const CustomCard();
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    const height = 600.0;
    return Scaffold(
        backgroundColor: Colors.transparent,
        // Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () async {},
          backgroundColor: Colors.greenAccent,
          child: IconButton(
            onPressed: () {
              print(widget.toString());
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
                '2021-22 Sem1',
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
