import 'package:IITDAPP/routes/Routes.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AppDrawer extends StatelessWidget {
  AppDrawer({Key key, this.tag}) : super(key: key);
  String tag;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 100,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/icon.jpg'),
                    fit: BoxFit.fill)),
            // child: Container(
            //     margin: EdgeInsets.fromLTRB(145, 120, 0, 0),
            //     // color: Colors.red,
            //     child: Text(
            //       'IITD APP',
            //       style: GoogleFonts.montserrat(
            //           fontSize: 35,
            //           color: Color(0xffffffff),
            //           shadows: <Shadow>[
            //             Shadow(
            //               offset: Offset(0, 0),
            //               blurRadius: 3.0,
            //               color: Color.fromARGB(100, 0, 0, 0),
            //             ),
            //             Shadow(
            //               offset: Offset(0, 0),
            //               blurRadius: 3.0,
            //               color: Color.fromARGB(125, 0, 0, 0),
            //             )
            //           ]),
            //     )),
          ),
          _createDrawerItem(
            selected: tag == 'User Dashboard',
            icon: Icons.account_circle_outlined,
            text: 'User Dashboard',
            context: context,
            routeName: Routes.dashboard,
          ),
          // _createDrawerItem(
          //   selected: tag == 'Search User',
          //   icon: CupertinoIcons.search,
          //   text: 'Search User',
          //   context: context,
          //   routeName: Routes.search,
          // ),
          const Divider(),
          ListTile(
            title: Text('Around'),
            onTap: () {},
          ),
          // _createDrawerItem(
          //     selected: tag == 'Courses',
          //     icon: Icons.bookmark_border_outlined,
          //     text: 'Courses',
          //     context: context,
          //     routeName: Routes.coursesPage),
          _createDrawerItem(
              selected: tag == 'Events',
              icon: Icons.emoji_events_outlined,
              text: 'Events',
              context: context,
              routeName: Routes.events,
              loginRequired: true),
          _createDrawerItem(
              selected: tag == 'Calendar',
              icon: CupertinoIcons.calendar,
              text: 'Calendar',
              context: context,
              routeName: Routes.calendar,
              loginRequired: false),
          const Divider(),
          ListTile(
            title: Text(
              'Utility',
            ),
            onTap: () {},
          ),
          _createDrawerItem(
            selected: tag == 'Attendance',
            icon: Icons.group_add_outlined,
            text: 'Attendance',
            context: context,
            routeName: Routes.attendance,
          ),
          _createDrawerItem(
              selected: tag == 'Quick Links',
              icon: CupertinoIcons.link,
              icon_size: 20,
              text: 'Quick Links',
              context: context,
              routeName: Routes.quickLinks),
          // Divider(),
          // ListTile(
          //   title: Text(
          //     'Discussion Forum',
          //   ),
          //   onTap: () {},
          // ),
          // _createDrawerItem(
          //   selected: tag == 'Chats',
          //   icon: CupertinoIcons.chat_bubble_2,
          //   text: 'Chats',
          //   context: context,
          //   routeName: Routes.discussionForum,
          // ),
          const Divider(),
          ListTile(
            title: Text('Discover'),
            onTap: () {},
          ),
          _createDrawerItem(
            selected: tag == 'Explore',
            icon: CupertinoIcons.compass,
            text: 'Explore',
            context: context,
            routeName: Routes.explore,
          ),
          _createDrawerItem(
            selected: tag == 'Campus Map',
            icon: CupertinoIcons.map_pin_ellipse,
            text: 'Campus Map',
            context: context,
            routeName: Routes.map,
          ),
          _createDrawerItem(
            selected: tag == 'News',
            icon: CupertinoIcons.news_solid,
            text: 'News',
            context: context,
            routeName: Routes.news,
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon,
      String text,
      double icon_size,
      // GestureTapCallback onTap,
      bool selected,
      BuildContext context,
      String routeName,
      bool loginRequired = false}) {
    return Ink(
      color: selected ? Color.fromARGB(30, 1, 87, 155) : Colors.transparent,
      child: ListTile(
          selected: selected,
          title: Row(
            children: <Widget>[
              Icon(
                icon,
                size: icon_size,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(text),
              )
            ],
          ),
          onTap: () => {
                if (currentUser == null && loginRequired)
                  {
                    Navigator.pop(context),
                    if (!selected)
                      Navigator.pushReplacementNamed(context, Routes.reqLogin,
                          arguments: text),
                  }
                else
                  {
                    Navigator.pop(context),
                    if (!selected)
                      Navigator.pushReplacementNamed(context, routeName),
                  }
              }),
    );
  }
}
