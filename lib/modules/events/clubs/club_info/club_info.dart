// import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
// import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
//import 'package:gradient_app_bar/gradient_app_bar.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';

import '../club_class.dart';
// import './club_about.dart';
import './club_events.dart';
import './club_info_card.dart';
import '../../events/event_class.dart';

// Future<List<Event>> getClubEvents(String id) async {
//   final response = await http.get('$url/api/events/?body=$id',
//       headers: {'authorization': 'Bearer $token'});
//   if (response.statusCode == 200) {
//     var parsedJson = json.decode(response.body);
//     var events = <Event>[];
//     if (parsedJson['message'] != 'Events Found') return events;
//     for (var i = 0; i < parsedJson['data']['events'].length; i++) {
//       var ev = Event.fromJson(parsedJson['data']['events'][i]);
//       events.add(ev);
//     }
//     events.sort((a, b) {
//       return a.startsAt.compareTo(b.startsAt);
//     });
//     events.sort((a, b) {
//       if (a.isStarred == b.isStarred) return 0;
//       return (a.isStarred) ? -1 : 1;
//     });
//     return events;
//   } else {
//     throw Exception('Failed to load clubs');
//   }
// }

class ClubInfo extends StatefulWidget {
  final Club _club;

  ClubInfo(this._club);

  @override
  State<StatefulWidget> createState() {
    return ClubInfoState();
  }
}

class ClubInfoState extends State<ClubInfo> {
  Club _club;
  List<Event> events;

  @override
  void initState() {
    super.initState();
    _club = widget._club;
    // events = getClubEvents(_club.id);
  }

  @override
  Widget build(BuildContext context) {
    // events = Provider.of<EventsTabProvider>(context, listen: false)
    //     .allEvents
    //     .where((element) => element.eventBody.id == _club.id)
    //     .toList();
    // events.sort((a, b) {
    //   return a.startsAt.compareTo(b.startsAt);
    // });
    // events.sort((a, b) {
    //   if (a.isStarred == b.isStarred) return 0;
    //   return (a.isStarred) ? -1 : 1;
    // });
    return Scaffold(
        backgroundColor:
            Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
        appBar: AppBar(
          title: Text('Club'),
          centerTitle: true,
          backgroundColor: Provider.of<ThemeModel>(context).theme.APP_BAR_START,
          //backgroundColorEnd:
          //Provider.of<ThemeModel>(context).theme.APP_BAR_END,
          // actions: <Widget>[ProfileIcon()],
        ),
        body: ListView(children: <Widget>[
          ClubInfoCard(_club),
          // ClubAbout(_club.clubAbout),
          ClubEvents(_club.id)
        ]));
  }
}
