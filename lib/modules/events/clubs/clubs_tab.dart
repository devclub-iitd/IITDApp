import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
// import 'package:IITDAPP/values/Constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:http/http.dart' as http;
import 'package:IITDAPP/modules/events/clubs/clubs_screen.dart';
// import 'dart:async';
// import 'dart:convert';

// import 'package:IITDAPP/modules/events/globals.dart';
// import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
// import './club_class.dart';
import './clubs_screen.dart';

// Future<List<List<Club>>> getClubs() async {
//   print('Getting Clubs');
//   // ignore: omit_local_variable_types
//   final LocalStorage localStorage = LocalStorage('iitdapp');
//   var returnObj;
//   var timeOutFlag = false;
//   final response = await http.get(
//     '$url/api/body',
//     headers: {'authorization': 'Bearer $token'},
//   ).timeout(
//     Duration(seconds: 5),
//     onTimeout: () async {
//       var parsedJson = await localStorage.getItem('clubs');
//       returnObj = handleGetClubsSuccess(parsedJson);
//       timeOutFlag = true;
//       return null;
//     },
//   );
//   connectedToInternet = !timeOutFlag;
//   if (timeOutFlag) {
//     return returnObj;
//   }
//   print(response.statusCode);
//   if (response.statusCode == 200) {
//     var parsedJson = json.decode(response.body);
//     returnObj = handleGetClubsSuccess(parsedJson);
//     await localStorage.setItem('clubs', parsedJson);
//   } else {
//     throw Exception('Failed to load clubs');
//   }
//   return returnObj;
// }

// List<List<Club>> handleGetClubsSuccess(var parsedJson) {
//   allClubs.clear();
//   subbedClubs.clear();
//   otherClubs.clear();
//   for (var i = 0; i < parsedJson['data'].length; i++) {
//     var club = Club.fromJson(parsedJson['data'][i]);
//     allClubs.add(club);
//     if (club.isSubbed) {
//       subbedClubs.add(club);
//     } else {
//       otherClubs.add(club);
//     }
//   }
//   subbedClubs.sort((a, b) {
//     return a.clubName.toLowerCase().compareTo(b.clubName.toLowerCase());
//   });
//   otherClubs.sort((a, b) {
//     return a.clubName.toLowerCase().compareTo(b.clubName.toLowerCase());
//   });
//   return [subbedClubs, otherClubs];
// }

class ClubsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('clubs_tab build called');
    // return FutureBuilder(
    //   future: getClubs(),
    //   builder: (context, snapshot) {
    return Consumer<EventsTabProvider>(
      builder: (context, provider, child) {
        if (provider.error) {
          return Center(
            child: Text(
              'Some Error Occured',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w200,
              ),
            ),
          );
        } else if (provider.loaded) {
          return ClubsScreen();
          // ListView(
          //   key: PageStorageKey('clubsTab'),
          //   physics: AlwaysScrollableScrollPhysics(),
          //   children: <Widget>[
          //     Container(
          //       height: 5,
          //     ),
          //     ClubsList(
          //       0,
          //       'SUBSCRIBED CLUBS',
          //     ),
          //     ClubsList(
          //       1,
          //       'OTHER CLUBS',
          //     ),
          //     Container(
          //       height: 5,
          //     ),
          //   ],
          // );
        }

        return Center(
          child: CircularProgressIndicator(
              // valueColor: AlwaysStoppedAnimation<Color>(
              //     Provider.of<ThemeModel>(context,listen:false).theme.PRIMARY_TEXT_COLOR,
              //     ),
              ),
        );
      },
    );
  }
}
