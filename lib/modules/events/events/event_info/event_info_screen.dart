import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
//import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../event_class.dart';
import './event_info_card.dart';
import './event_about.dart';
import './event_updates_list.dart';

Future<Event> getEvent(String eventid) async {
  final response = await http.get('$uri/api/events/$eventid',
      headers: {'authorization': 'Bearer $token'});
  if (response.statusCode == 200) {
    var parsedJson = json.decode(response.body);
    var event = Event.fromJson(parsedJson['event']);
    return event;
  } else {
    throw Exception('Failed to load Event');
  }
}

class EventInfo extends StatefulWidget {
  final String id;
  // final Function _reorderLists;
  final bool showButton;

  EventInfo(this.id, {this.showButton = true});

  @override
  State<StatefulWidget> createState() {
    return EventInfoState();
  }
}

class EventInfoState extends State<EventInfo> {
  String id;

  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeModel>(context).theme.APP_BAR_START,
        //backgroundColorEnd: Provider.of<ThemeModel>(context).theme.APP_BAR_END,
        title: Text('Event'),
        centerTitle: true,
        // actions: <Widget>[ProfileIcon()],
      ),
      body: FutureBuilder(
        future: getEvent(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: <Widget>[
                EventInfoCard(
                  snapshot.data,
                  showButton: widget.showButton,
                ),
                EventAbout(snapshot.data),
                EventUpdatesList(snapshot.data.eventid)
              ],
            );
          } else if (snapshot.hasError) {
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

          return Center(
            child: CircularProgressIndicator(
                // valueColor: AlwaysStoppedAnimation<Color>(
                //     Provider.of<ThemeModel>(context,listen:false).theme.PRIMARY_TEXT_COLOR),
                ),
          );
        },
      ),
    );
  }
}
