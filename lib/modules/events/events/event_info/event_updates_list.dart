import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/sectionTitle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import './updates_class.dart';
import './update.dart';

Future<List<dynamic>> getUpdates(String eventid) async {
  final response = await http.get('$uri/api/events/$eventid',
      headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    var parsedJson = json.decode(response.body);
    // ignore: prefer_collection_literals
    var updateList = [];
    for (var i = 0; i < parsedJson['event']['updates'].length; i++) {
      var update = Update.fromJson(parsedJson['event']['updates'][i]);
      updateList.add(update);
    }
    print(updateList);
    return updateList;
  } else {
    throw Exception('Failed');
  }
}

class EventUpdatesList extends StatefulWidget {
  final String eventid;

  const EventUpdatesList(this.eventid);

  @override
  State<StatefulWidget> createState() {
    return EventUpdatesListState();
  }
}

class EventUpdatesListState extends State<EventUpdatesList> {
  Future<List<dynamic>> _updates;
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
          SectionTitle(
            title: 'UPDATES',
          ),
          SectionUnderLine(),
          FutureBuilder(
            future: _updates,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic> upd = snapshot.data;
                if (upd.isEmpty) {
                  return Container(
                    margin: EdgeInsets.all(25),
                    child: Center(
                      child: Text(
                        'No Updates',
                        style: TextStyle(
                          color: Provider.of<ThemeModel>(context)
                              .theme
                              .PRIMARY_TEXT_COLOR
                              .withOpacity(0.7),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: upd
                        .map((element) =>
                            EventUpdate(element, ValueKey(element.id)))
                        .toList(),
                  );
                }
              } else if (snapshot.hasError) {
                print(snapshot);
                return Center(
                  child: Text(
                    'Some Error Occured',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              }

              return Container(
                margin: EdgeInsets.all(20),
                child: Center(
                  child: CircularProgressIndicator(
                      // valueColor: AlwaysStoppedAnimation<Color>(
                      //     Provider.of<ThemeModel>(context,listen:false).theme.PRIMARY_TEXT_COLOR),
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
