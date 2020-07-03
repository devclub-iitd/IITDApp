import 'package:IITDAPP/modules/quickLinks/screens/LinksScreen.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickLinks extends StatefulWidget {
  static const String routeName = '/quickLinks';

  @override
  _QuickLinksState createState() => _QuickLinksState();
}

class _QuickLinksState extends State<QuickLinks> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: CustomAppBar(
        title: Text('Quick Links'),
      ),
      drawer: AppDrawer(tag: 'Quick Links'),
      body: LinksScreen(),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Academic Links',
              style: GoogleFonts.abhayaLibre(fontSize: 25),
            ),
            Container(
              height: 3,
              width: 80,
              margin: EdgeInsets.symmetric(vertical: 8),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}

class Links extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
            child: Text(
              'Timble',
              style: GoogleFonts.sacramento(fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
