import 'package:flutter/material.dart';
import 'package:iitd_app/utils/colors.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
         Padding(
           padding: const EdgeInsets.all(0),
           child: DrawerHeader(
                 
            decoration: BoxDecoration(
              color: AppColors.primaryColorDark,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Townsquare',
                  style: TextStyle(
                    color: AppColors.secondaryColorLight,
                    fontSize: 24,
                  ),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
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
        Expanded(child: Container()),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal:15.0),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
             children: [
               Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(image: AssetImage("assets/images/devCLogo.png"),fit: BoxFit.cover)
                        ),
                      ),
                      SizedBox(width: 20,),
               Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(image: AssetImage("assets/images/iitd_building.jpg"),fit: BoxFit.cover)
                        ),
                      ),

             ],
           ),
         ),
                
      ],
    ),
  );
}
