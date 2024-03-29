import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iitd_app/utils/colors.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
         Padding(
           padding: const EdgeInsets.all(0),
           child: DrawerHeader(
                 
            decoration: const BoxDecoration(
              color: AppColors.primaryColorDark,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Townsquare',
                  style: TextStyle(
                    color: AppColors.secondaryColorLight,
                    fontSize: 24,
                  ),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/iitd_building.jpg"),fit: BoxFit.cover)
                  ),
                ),
                
              ],
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
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.link),
          title: const Text('Quick Links'),
          onTap: () {
            Navigator.pushNamed(context, '/quicklinks');
          },
        ),
        ListTile(
          leading: const FaIcon(FontAwesomeIcons.heart),
          title: const Text('Liked Events'),
          onTap: () {
            Navigator.pushNamed(context, '/liked');
          },
        ),
      ],
    ),
  );
}
