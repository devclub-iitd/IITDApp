import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../events/event_info/updates_class.dart';
import './update.dart';
import './add_update.dart';
import 'package:IITDAPP/modules/events/globals.dart';

class EventUpdatesList extends StatefulWidget {
  final String eventid;

  EventUpdatesList(this.eventid);

  @override
  State<StatefulWidget> createState() {
    return _EventUpdateList();
  }
}

class _EventUpdateList extends State<EventUpdatesList> {
  // List<Update> _updates;
  String id;
  Future<List<Update>> _updates;

  @override
  void initState() {
    super.initState();
    id = widget.eventid;
    _updates = getUpdates(id);
  }

  Future<List<Update>> getUpdates(String eventid) async {
    print("getting updates");
    final response = await http.get('$url/api/events/$eventid',
        headers: {'authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      var updateList = List<Update>();
      for (var i = 0; i < parsedJson['event']['updates'].length; i++) {
        var update = Update.fromJson(parsedJson['event']['updates'][i]);
        updateList.add(update);
      }
      // _updates = updateList;
      return updateList;
    } else {
      throw Exception('Failed');
    }
  }

  void _reload() {
      _updates = getUpdates(id);
      setState(() {
        
      });
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
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                List<Update> upd = snapshot.data;
                if (upd.isEmpty)
                  return Container(
                    margin: EdgeInsets.all(25),
                    child: Center(
                      child: Text(
                        "No Updates",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  );
                else
                  return Column(
                    children: upd
                        .map((element) => EventUpdate(
                            element, _reload, id, ValueKey(element.id)))
                        .toList(),
                  );
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
          AddUpdate(_reload, id),
        ],
      ),
    );
  }
}
