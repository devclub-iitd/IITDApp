import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/sectionTitle.dart';
import 'package:flutter/material.dart';
// import 'package:IITDAPP/modules/events/globals.dart';

import './club_class.dart';
import './club_card.dart';

class ClubsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ClubsScreenState();
  }
}

class ClubsScreenState extends State<ClubsScreen> {
  // void refresh() {
  //   print('refreshing club list');
  //   // if (widget.l == 0)
  //   //   clubs = subbedClubs;
  //   // else if (widget.l == 1) clubs = otherClubs;
  //   // clubs.forEach((f) => print(f.clubName));
  //   subbedClubs.sort((a, b) {
  //     return a.clubName.toLowerCase().compareTo(b.clubName.toLowerCase());
  //   });
  //   otherClubs.sort((a, b) {
  //     return a.clubName.toLowerCase().compareTo(b.clubName.toLowerCase());
  //   });
  //   print('Subbed Clubs:');
  //   subbedClubs.forEach((f) => print(f.clubName));
  //   print('Other Clubs:');
  //   otherClubs.forEach((f) => print(f.clubName));
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    print('ClubScreenState build called');
    return ListView(
      key: PageStorageKey('clubsTab'),
      physics: AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          height: 5,
        ),
        clubsList(
          'SUBSCRIBED CLUBS',
          Provider.of<EventsTabProvider>(context, listen: false).subbedClubs,
        ),
        clubsList('OTHER CLUBS', Provider.of<EventsTabProvider>(context, listen: false).otherClubs),
        Container(
          height: 5,
        ),
      ],
    );
  }

  List<ClubCard> makeClubCardList(List<Club> clubs) {
    print('makeClubCardList received:::');
    clubs.forEach((f) => print(f.clubName));
    // ignore: prefer_collection_literals
    var toReturn = List<ClubCard>();
    for (var i = 0; i < clubs.length; i++) {
      toReturn.add(ClubCard(clubs[i], ValueKey(clubs[i].id)));
      print('adding + ${clubs[i].clubName}');
    }
    print('To return:');
    toReturn.forEach((f) => print(f.club.clubName));
    return toReturn;
  }

  Widget clubsList(String listTitle, List<Club> clubs) {
    print('clublist method called with title : $listTitle');
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionTitle(
            title: listTitle,
          ),
          SectionUnderLine(),
          (clubs.isEmpty)
              ? Center(
                  // padding: EdgeInsets.all(20),
                  child: Text(
                    'No Clubs',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w300,
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .PRIMARY_TEXT_COLOR
                            .withOpacity(0.7)),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 2,
                            color: Provider.of<ThemeModel>(context)
                                .theme
                                .PRIMARY_TEXT_COLOR
                                .withOpacity(0.1))
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: makeClubCardList(clubs),
                      // clubs
                      //     .map((element) => ClubCard(element, refresh))
                      //     .toList(),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
