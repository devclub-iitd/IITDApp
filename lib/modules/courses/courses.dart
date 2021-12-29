// TODO: fetch data, update data to backend about couyrss, make changes as discussed with pranjal sir,make the books and major minor sections into expandable panel
//TODO: in improv week, swipe remove option, and maybe long press preview option and reordering the courses option, irritating when keyboard dismisses and comes back again while adding/removing courses.
import 'package:IITDAPP/modules/courses/widgets/customCard.dart';
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
// import 'package:IITDAPP/modules/courses/data/coursedata.dart';
import 'package:IITDAPP/modules/courses/widgets/coursecard.dart';
import 'package:IITDAPP/modules/courses/widgets/heading.dart';
import 'package:IITDAPP/modules/courses/screens/search.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:IITDAPP/modules/login/user_class.dart';
// import 'package:IITDAPP/modules/courses/data/coursedata.dart';

class CoursesScreen extends StatefulWidget {
  static const String routeName = '/courses';
  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with TickerProviderStateMixin {
  Widget appBar;
  var showPopUp;
  @override
  void initState() {
    //_controller = TabController(length: 3, vsync: this);
    appBar = CustomAppBar(
      title: Text('Courses'),
      height: 1,
    );
    showPopUp = false;
    // your = savedstate.getstate() ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    for (int i = 0; i < alldepartments.keys.length; i++) {
      print(alldepartments.keys.toList()[i]);
    }
    print(alldepartments.keys.length);
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
=======
    return WillPopScope(
      onWillPop: () {
        if (showPopUp) {
          setState(() {
            showPopUp = false;
          });
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        backgroundColor:
            Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
        appBar: appBar,
        drawer: AppDrawer(
          tag: 'Courses',
        ),
        body: Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
>>>>>>> 33ff04f959c9f70f14d58cfeb772e3032abe4be8
            GestureDetector(
              onTap: () {
                setState(() {
                  print('Gesture Detector');
                  showPopUp = false;
                });
              },
              child: SingleChildScrollView(
                child: Opacity(
                  opacity: showPopUp ? 0.2 : 1,
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
                          // show the dialog
                          setState(() {
                            showPopUp = !showPopUp;
                          });
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            //color: Provider.of<ThemeModel>(context).theme.cardColor,
                            color: Provider.of<ThemeModel>(context)
                                .theme
                                .LinksSectionStart,
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              //color: Colors.red,
                              padding: EdgeInsets.fromLTRB(18, 18, 18, 18),
                              child: Text("Export To Calender",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.white)),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              child: Container(
                            height: 72,
                            child: Heading('Your Courses', 28),
                          )),
                          Container(
                            height: 70,
                            width: 100,
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: IconButton(
                                onPressed: () {
                                  showSearch(
                                      context: context, delegate: Search());
                                },
                                icon: Icon(
                                  CupertinoIcons.search,
                                  size: 32,
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
                            : currentUser.courses
                                .map((e) => CourseCard(e))
                                .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            showPopUp
                ? Center(
                    child: Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: CustomCard(),
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 0,
                  ),
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              Container(
                width: 20,
              ),
              Icon(
                widget._course.icondata,
                color: widget._course.color,
                size: 28,
              ),
              Container(
                width: 12,
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  widget._course.name.toUpperCase() +
                      '  (${widget._course.slot})',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: widget._course.color),
                ),
              ),
              Container(
                width: 12,
              ),
              // Text(
              //   '(${widget._course.slot})',
              //   style: TextStyle(fontSize: 20, color: Colors.white),
              // ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
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
          ),
        ],
      ),
    );
  }
}
