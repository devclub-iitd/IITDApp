import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:IITDAPP/modules/events/globals.dart';
import 'dart:convert';
import 'dart:async';

import '../club_class.dart';
import './club_about.dart';
import './club_events.dart';
import './club_info_card.dart';
import '../../events/event_class.dart';

Future<List<Event>> getClubEvents(String id) async {
  final response = await http
      .get("$url/api/events/?body=$id", headers: {
    "authorization":
        "Bearer $token"
  });
  if (response.statusCode == 200) {
    var parsedJson = json.decode(response.body);
    List<Event> events = List<Event>();
    if (parsedJson["message"] != "Events Found") return events;
    for (int i = 0; i < parsedJson["data"]["events"].length; i++) {
      Event ev = Event.fromJson(parsedJson["data"]["events"][i]);
      events.add(ev);
    }
    events.sort((a, b) {
      return a.startsAt.compareTo(b.startsAt);
    });
    events.sort((a, b) {
      if (a.isStarred == b.isStarred) return 0;
      return (a.isStarred)? -1:1;
    });
    return events;
  } else {
    throw Exception('Failed to load clubs');
  }
}

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
  Future<List<Event>> events;

  @override
  void initState() {
    super.initState();
    _club = widget._club;
    events = getClubEvents(_club.id);
  }

  void reload() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('Club'),
        centerTitle: true,
        backgroundColorStart: Colors.indigo,
        backgroundColorEnd: Colors.cyan,
        // actions: <Widget>[ProfileIcon()],
      ),
      body: ListView(
        children: <Widget>[
          ClubInfoCard(_club),
          ClubAbout(_club.clubAbout),
          FutureBuilder(
            future: events,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ClubEvents(snapshot.data, reload);
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Could not get events",
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              }

              return Container(
                margin: EdgeInsets.all(20),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
