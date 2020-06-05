import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:IITDAPP/modules/events/globals.dart';
import './updates_class.dart';
import './update.dart';

Future<List<Update>> getUpdates(String eventid) async {
  final response = await http.get('$url/api/events/$eventid',
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    var parsedJson = json.decode(response.body);
    List<Update> updateList = List<Update>();
    for (var i = 0; i < parsedJson['event']['updates'].length; i++) {
      var update = Update.fromJson(parsedJson['event']['updates'][i]);
      updateList.add(update);
    }
    return updateList;
  } else {
    throw Exception('Failed');
  }
}

class EventUpdatesList extends StatefulWidget {
  final String eventid;

  EventUpdatesList(this.eventid);

  @override
  State<StatefulWidget> createState() {
    return EventUpdatesListState();
  }
}

class EventUpdatesListState extends State<EventUpdatesList> {
  Future<List<Update>> _updates;
  String eventid;

  @override
  void initState() {
    super.initState();
    eventid = widget.eventid;
    _updates = getUpdates(eventid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'UPDATES',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 15,
                letterSpacing: 4),
          ),
          Container(
            height: 3,
            width: 60,
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Colors.blue,
          ),
          FutureBuilder(
            future: _updates,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Update> upd = snapshot.data;
                if (upd.isEmpty) {
                  return Container(
                    margin: EdgeInsets.all(25),
                    child: Center(
                      child: Text(
                        'No Updates',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children:
                        upd.map((element) => EventUpdate(element, ValueKey(element.id))).toList(),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Some Error Occured',
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
          ),
        ],
      ),
    );
  }
}
