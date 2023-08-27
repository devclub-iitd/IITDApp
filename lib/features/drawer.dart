import 'package:flutter/material.dart';
import 'package:iitd_app/utils/colors.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: AppColors.primaryColorDark,
          ),
          child: Text(
            'Townsquare',
            style: TextStyle(
              color: AppColors.secondaryColorLight,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.event_sharp),
          title: const Text('Events'),
          onTap: () {
            Navigator.pushNamed(context, '/events');
          },
        ),
        ListTile(
          leading: const Icon(Icons.search),
          title: const Text('Lost and Found'),
          onTap: () {
            Navigator.pushNamed(context, '/lostandfound');
          },
        ),
        ListTile(
          leading: const Icon(Icons.house),
          title: const Text('Clubs/Boards'),
          onTap: () {
            Navigator.pushNamed(context, '/clubs');
          },
        ),
        ListTile(
          leading: const Icon(Icons.celebration),
          title: const Text('Hangouts'),
          onTap: () {
            Navigator.pushNamed(context, '/hangouts');
          },
        ),
        ListTile(
          leading: const Icon(Icons.newspaper),
          title: const Text('News'),
          onTap: () {
            Navigator.pushNamed(context, '/news');
          },
        ),
      ],
    ),
  );
}
