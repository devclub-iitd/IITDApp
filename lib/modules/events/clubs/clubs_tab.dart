import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:IITDAPP/modules/events/clubs/clubs_screen.dart';
import 'dart:async';
import 'dart:convert';

import 'package:IITDAPP/modules/events/globals.dart';
import 'package:localstorage/localstorage.dart';
import './club_class.dart';
import './clubs_screen.dart';

Future<List<List<Club>>> getClubs() async {
  print('Getting Clubs');
  // ignore: omit_local_variable_types
  final LocalStorage localStorage = LocalStorage('iitdapp');
  var returnObj;
  var timeOutFlag = false;
  final response = await http.get(
    '$url/api/body',
    headers: {'authorization': 'Bearer $token'},
  ).timeout(
    Duration(seconds: 5),
    onTimeout: () async {
      var parsedJson = await localStorage.getItem('clubs');
      returnObj = handleGetClubsSuccess(parsedJson);
      timeOutFlag = true;
      return null;
    },
  );
  connectedToInternet = !timeOutFlag;
  if(timeOutFlag) {
    return returnObj;
  }
  print(response.statusCode);
  if (response.statusCode == 200) {

    var parsedJson = json.decode(response.body);
    returnObj = handleGetClubsSuccess(parsedJson);
    await localStorage.setItem('clubs', parsedJson);

  } else {
    throw Exception('Failed to load clubs');
  }
  return returnObj;
}

List<List<Club>> handleGetClubsSuccess(var parsedJson) {
  allClubs.clear();
  subbedClubs.clear();
  otherClubs.clear();
  for (var i = 0; i < parsedJson['bodies'].length; i++) {
    var club = Club.fromJson(parsedJson['bodies'][i]);
    allClubs.add(club);
    if (club.isSubbed) {
      subbedClubs.add(club);
    } else {
      otherClubs.add(club);
    }
  }
  subbedClubs.sort((a, b) {
    return a.clubName.toLowerCase().compareTo(b.clubName.toLowerCase());
  });
  otherClubs.sort((a, b) {
    return a.clubName.toLowerCase().compareTo(b.clubName.toLowerCase());
  });
  return [subbedClubs, otherClubs];
}


class ClubsTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('clubs_tab build called');
    return FutureBuilder(
      future: getClubs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('snap hasdata');
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
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Some Error Occured',
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      },
    );
  }
}
