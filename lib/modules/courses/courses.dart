// TODO: fetch data, update data to backend about couyrss, make changes as discussed with pranjal sir,make the books and major minor sections into expandable panel
//TODO: in improv week, swipe remove option, and maybe long press preview option and reordering the courses option, irritating when keyboard dismisses and comes back again while adding/removing courses.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/modules/courses/data/coursedata.dart';
import 'package:IITDAPP/modules/courses/widgets/coursecard.dart';
import 'package:IITDAPP/modules/courses/widgets/heading.dart';
import 'package:IITDAPP/modules/courses/screens/search.dart';

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
    your = savedstate.getstate() ?? [];
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Container(
                  height: 80,
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
              children: your.map((e) => CourseCard(e)).toList(),
            ),
            Container(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
