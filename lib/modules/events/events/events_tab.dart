import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:IITDAPP/modules/events/globals.dart';
import 'package:localstorage/localstorage.dart';
import './events_page.dart';
import './event_class.dart';

Widget loadingIcon() {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    ),
  );
}

Widget errorMessage() {
  return Center(
    child: Text(
      'Some Error Occured',
      style: TextStyle(color: Colors.white70),
    ),
  );
}

class EventsTab extends StatefulWidget {
  final TabController _controller;

  EventsTab(this._controller);

  @override
  State<StatefulWidget> createState() {
    return EventsTabState();
  }
}

class EventsTabState extends State<EventsTab> {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget._controller;
  }

  Future<List<List<List<Event>>>> getEvents() async {
    print('Getting Events');
    // ignore: omit_local_variable_types
    final LocalStorage localStorage = LocalStorage('iitdapp');
    var timeOutFlag = false;
    var returnObj;
    final response = await http
        .get('$url/api/events', headers: {'authorization': 'Bearer $token'}).timeout(
      Duration(seconds: 5),
      onTimeout: () async {
        var parsedJson = await localStorage.getItem('events');
        returnObj = handleGetEventsSuccess(parsedJson);
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
      print('Events received');
      var parsedJson = json.decode(response.body);
      returnObj = handleGetEventsSuccess(parsedJson);
      await localStorage.setItem('events', parsedJson);
    } else {
      throw Exception('Failed to load events');
    }
    return returnObj;
  }

  // ignore: always_declare_return_types
  handleGetEventsSuccess(var parsedJson){
    todayEvents = List<List<Event>>.generate(3, (i) => []);
    tomorrowEvents = List<List<Event>>.generate(3, (i) => []);
    upcomingEvents = List<List<Event>>.generate(3, (i) => []);
    // ignore: prefer_collection_literals
    eventsList = List<Event>();
    if (parsedJson['message'] != 'Events Found') {
      return [todayEvents, tomorrowEvents, upcomingEvents];
    }
    print(parsedJson['data']['events'].length);
    for (var i = 0; i < parsedJson['data']['events'].length; i++) {
      var ev = Event.fromJson(parsedJson['data']['events'][i]);
      eventsList.add(ev);
    }
    return sortEvents();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getEvents(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TabBarView(
            controller: _controller,
            children: [
              EventsPage('TODAY'),
              EventsPage('TOMORROW'),
              EventsPage('UPCOMING'),
            ],
          );
        } else if (snapshot.hasError) {
          // print(snapshot.data);
          return TabBarView(
            controller: _controller,
            children: [
              errorMessage(),
              errorMessage(),
              errorMessage(),
            ],
          );
        }
        return TabBarView(
          controller: _controller,
          children: [
            loadingIcon(),
            loadingIcon(),
            loadingIcon(),
          ],
        );
      },
    );
  }
}
