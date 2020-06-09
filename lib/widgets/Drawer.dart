import 'package:IITDAPP/routes/Routes.dart';
import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:flutter/material.dart';

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
            child: Text('IITD APP'),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/iitd_building.jpg'),
                    fit: BoxFit.cover)),
          ),
          _createDrawerItem(
            selected: tag == 'User Dashboard',
            icon: Icons.contacts,
            text: 'User Dashboard',
            context: context,
            routeName: Routes.dashboard,
          ),
          Divider(),
          ListTile(
            title: Text('Around'),
            onTap: () {},
          ),
          _createDrawerItem(
              selected: tag == 'Events',
              icon: Icons.event,
              text: 'Events',
              context: context,
              routeName: Routes.events,
              loginRequired: true),
          _createDrawerItem(
              selected: tag == 'Calendar',
              icon: Icons.calendar_today,
              text: 'Calendar',
              context: context,
              routeName: Routes.calendar,
              loginRequired: true),
          Divider(),
          ListTile(
            title: Text(
              'Utility',
            ),
            onTap: () {},
          ),
          _createDrawerItem(
            selected: tag == 'Attendance',
            icon: Icons.stars,
            text: 'Attendance',
            context: context,
            routeName: Routes.attendance,
          ),
          _createDrawerItem(
              selected: tag == 'Quick Links',
              icon: Icons.stars,
              text: 'Quick Links',
              context: context,
              routeName: Routes.quickLinks),
          Divider(),
          ListTile(
            title: Text('Discover'),
            onTap: () {},
          ),
          _createDrawerItem(
            selected: tag == 'Explore',
            icon: Icons.explore,
            text: 'Explore',
            context: context,
            routeName: Routes.explore,
          ),
          _createDrawerItem(
            selected: tag == 'Campus Map',
            icon: Icons.map,
            text: 'Campus Map',
            context: context,
            routeName: Routes.map,),
          _createDrawerItem(
              selected: tag == 'News',
              icon: Icons.fiber_new,
              text: 'News',
            context: context,
            routeName: Routes.news,),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon,
      String text,
      GestureTapCallback onTap,
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
              Icon(icon),
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
