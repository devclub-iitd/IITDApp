// TODO: fetch data, update data to backend about couyrss, make changes as discussed with pranjal sir,make the books and major minor sections into expandable panel
//TODO: in improv week, swipe remove option, and maybe long press preview option and reordering the courses option, irritating when keyboard dismisses and comes back again while adding/removing courses.
import 'package:IITDAPP/values/Constants.dart';
import 'package:IITDAPP/widgets/course_class.dart';
import 'package:IITDAPP/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/modules/courses/data/coursedata.dart';
import 'package:IITDAPP/modules/courses/widgets/coursecard.dart';
import 'package:IITDAPP/modules/courses/widgets/heading.dart';
import 'package:IITDAPP/modules/courses/screens/search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/modules/courses/data/coursedata.dart';

class CoursesScreen extends StatefulWidget {
  static const String routeName = '/courses';
  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with TickerProviderStateMixin {
  Widget appBar;
  @override
  void initState() {
    //_controller = TabController(length: 3, vsync: this);
    appBar = CustomAppBar(
      title: Text('Courses'),
      height: 1,
    );
    // your = savedstate.getstate() ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: appBar,
      drawer: AppDrawer(
        tag: 'Courses',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                // color: Colors.red,
                // height: 10,
                ),
            GestureDetector(
              onTap: () {
                currentUser.tocalender =
                    currentUser.courses.map((e) => e).toList();
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;
                AlertDialog alert = AlertDialog(
                  title: Text("Export To Calender"),
                  content: Container(
                    height: height - 600,
                    // color: Colors.red,
                    child: Column(
                      children: [
                        Container(
                          height: height - 560,
                          width: width,
                          // color: Colors.green,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 10,
                                ),
                                ...currentUser.tocalender
                                    .map((e) => UserCourse(e))
                                    .toList(),
                                Container(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Back")),
                    TextButton(
                        onPressed: () =>
                            {export_to_calender(), Navigator.pop(context)},
                        child: Text("Export")),
                  ],
                );

                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  //color: Provider.of<ThemeModel>(context).theme.cardColor,
                  color:
                      Provider.of<ThemeModel>(context).theme.LinksSectionStart,
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Container(
                    //color: Colors.red,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Text("Export To Calender",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.white)),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Container(
                  height: 82,
                  child: Heading('Your Courses', 36),
                )),
                Container(
                  height: 80,
                  width: 100,
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: IconButton(
                      onPressed: () {
                        showSearch(context: context, delegate: Search());
                      },
                      icon: Icon(
                        CupertinoIcons.search,
                        size: 40,
                      )),
                ),
              ],
            ),
            Divider(
              height: 0,
              thickness: 4,
              color: Colors.cyan,
              indent: 30,
              endIndent: 220,
            ),
            Column(
              children: currentUser.courses == null
                  ? []
                  : currentUser.courses.map((e) => CourseCard(e)).toList(),
            ),
            Container(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  void export_to_calender() {
    unawaited(showLoading(context));

    //writehere

    Navigator.pop(context);
  }
}

class UserCourse extends StatefulWidget {
  final Course _course;
  const UserCourse(this._course);
  @override
  _UserCourseState createState() => _UserCourseState();
}

class _UserCourseState extends State<UserCourse> {
  @override
  Widget build(BuildContext context) {
    if (!currentUser.tocalender
        .any((element) => element.name == widget._course.name)) {
      return Container();
    }
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 190,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              // elevation: 5,
              color: Colors.red.shade600,
              // color: widget._course.color,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      //color: Colors.red,
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Icon(
                        widget._course.icondata,
                        color: Colors.white,
                        size: 20,
                      )),
                  Container(
                    //color: Colors.red,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(widget._course.name,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.white)),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Row(
                      children: [
                        Text(
                          widget._course.slot,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        // Container(
                        //     margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        //     // color: Colors.red,
                        //     child: Icon(
                        //       CupertinoIcons.arrowtriangle_down_fill,
                        //       size: 6,
                        //       color: Colors.white,
                        //     )),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        Container(
          height: 50,
          // color: Colors.red,
          child: IconButton(
            onPressed: () {
              currentUser.tocalender.remove(widget._course);
              setState(() {});
            },
            icon: Icon(CupertinoIcons.trash),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: widget._course.color,
          ),
        )
      ],
    );
  }
}
