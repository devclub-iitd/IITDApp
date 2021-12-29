import 'package:IITDAPP/widgets/course_class.dart';
import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/courses/screens/about.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseCard extends StatelessWidget {
  final Course _course;
  const CourseCard(this._course);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // onTap: () => Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => about(_name))),
        onTap: () => Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 200),
                transitionsBuilder: (BuildContext context,
                    Animation<double> first,
                    Animation<double> second,
                    Widget child) {
                  return FadeTransition(
                    opacity: first,
                    child: child,
                  );
                },
                pageBuilder: (BuildContext context, Animation<double> first,
                    Animation<double> second) {
                  return about(_course);
                })),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            //color: Provider.of<ThemeModel>(context).theme.cardColor,
            color: _course.color,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        //color: Colors.red,
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: _course.icon),
                    Container(
                      //color: Colors.red,
                      padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                      child: Text(_course.name,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 30,
                              color: Colors.white)),
                    ),
                  ],
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 30,
                    )),
              ],
            )));
  }
}
