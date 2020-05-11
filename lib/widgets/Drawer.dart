import 'package:IITDAPP/routes/Routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              icon: Icons.contacts,
              text: 'User Dashboard',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.dashboard)),
          Divider(),
          ListTile(
            title: Text('Around'),
            onTap: () {},
          ),
          _createDrawerItem(
              icon: Icons.event,
              text: 'Events',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.dashboard)),
          _createDrawerItem(icon: Icons.calendar_today, text: 'Calendar'),
          Divider(),
          ListTile(
            title: Text(
              'Utility',
            ),
            onTap: () {},
          ),
          _createDrawerItem(
              icon: Icons.stars,
              text: 'Attendance',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.attendance)),
          _createDrawerItem(icon: Icons.stars, text: 'Quick Links'),
          Divider(),
          ListTile(
            title: Text('Discover'),
            onTap: () {},
          ),
          _createDrawerItem(
              icon: Icons.explore,
              text: 'Explore',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, Routes.explore)),
          _createDrawerItem(icon: Icons.map, text: 'Campus Map'),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
