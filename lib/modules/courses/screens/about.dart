// ignore_for_file: camel_case_types

import 'package:IITDAPP/modules/courses/screens/search.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:IITDAPP/widgets/course_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/courses/widgets/heading.dart';
// import 'package:IITDAPP/modules/courses/widgets/icons.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/ThemeModel.dart';
// import 'package:IITDAPP/modules/courses/widgets/listcard.dart';
import 'package:google_fonts/google_fonts.dart';

class about extends StatefulWidget {
  final Course _course;
  const about(this._course);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: CustomAppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Icon(widget._course.icondata)),
          Text(widget._course.name.toUpperCase() + ' (${widget._course.slot})'),
          Spacer(),
          IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                var bad = AlertDialog(
                  content: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height: 40,
                    child: Text(
                      '${widget._course.name.toString().toUpperCase()} was removed from your courses.',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.maybePop(context),
                        child: Text('Okay'))
                  ],
                  elevation: 10,
                );
                var good = AlertDialog(
                  content: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    // height: 40,
                    child: Text(
                      '${widget._course.name.toString().toUpperCase()} was added to your courses.',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.maybePop(context),
                        child: Text('Okay'))
                  ],
                  elevation: 10,
                );
                if (currentUser.courses
                    .any((element) => element.name == widget._course.name)) {
                  currentUser.courses.removeWhere(
                      (element) => element.name == widget._course.name);
                  showDialog(context: context, builder: (_) => bad);
                } else {
                  currentUser.courses.add(widget._course);
                  showDialog(context: context, builder: (_) => good);
                }
                setState(() {});
              },
              icon: Icon(currentUser.courses
                      .any((element) => element.name == widget._course.name)
                  ? CupertinoIcons.trash
                  : CupertinoIcons.add_circled)),
        ]),
        withMenu: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Heading('Books', 30),
            Divider(
              height: 0,
              thickness: 4,
              color: Colors.cyan,
              indent: 30,
              endIndent: 220,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Center(
                child: Text(
                  "Coming Soon",
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            //       ListCard('Books', _course),
            Heading('Previous Year Papers', 30),
            Divider(
              height: 0,
              thickness: 4,
              color: Colors.cyan,
              indent: 30,
              endIndent: 220,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                child: Text(
                  "Coming Soon",
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
            //       ListCard('Minor 1', _course),
            //       ListCard('Minor 2', _course),
            //       ListCard('Major', _course),
            //       Container(
            //         height: 20,
            //       )
          ],
        ),
      ),
      // body: Center(
      //     child: Text(
      //   "Coming Soon",
      //   style: TextStyle(fontSize: 18),
      // )),
    );
  }
}
