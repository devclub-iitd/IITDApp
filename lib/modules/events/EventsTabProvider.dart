import 'dart:convert';

import 'package:IITDAPP/modules/events/events/event_class.dart';
// import 'package:IITDAPP/modules/events/globals.dart';
// import 'package:IITDAPP/modules/events/home.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

import 'clubs/club_class.dart';

class EventsTabProvider extends ChangeNotifier {
  // ignore: prefer_collection_literals
  final List<Event> _allEvents = [];
  // ignore: prefer_collection_literals
  final List<Club> _allClubs = [];

  List<List<Event>> _todayEvents = List<List<Event>>.generate(3, (i) => []);
  List<List<Event>> _tomorrowEvents = List<List<Event>>.generate(3, (i) => []);
  List<List<Event>> _upcomingEvents = List<List<Event>>.generate(3, (i) => []);

  // ignore: prefer_collection_literals
  final List<Club> _subbedClubs = [];
  // ignore: prefer_collection_literals
  final List<Club> _otherClubs = [];

  bool _loaded = false;
  bool _error = false;

  List<Event> get allEvents => _allEvents;
  List<Club> get allClubs => _allClubs;
  List<List<Event>> get todayEvents => _todayEvents;
  List<List<Event>> get tomorrowEvents => _tomorrowEvents;
  List<List<Event>> get upcomingEvents => _upcomingEvents;
  List<Club> get subbedClubs => _subbedClubs;
  List<Club> get otherClubs => _otherClubs;

  bool get loaded => _loaded;
  bool get error => _error;

  Future<void> getData() async {
    _loaded = false;
    _error = false;
    try {
      await getClubs();
      await getEvents();
    } on Exception catch (e) {
      _error = true;
      print(e);
    }
    _loaded = true;

    notifyListeners();
  }

  void handleGetClubsSuccess(var parsedJson) {
    _allClubs.clear();
    // _subbedClubs.clear();
    // _otherClubs.clear();
    for (var i = 0; i < parsedJson['data'].length; i++) {
      var club = Club.fromJson(parsedJson['data'][i]);
      _allClubs.add(club);
      // if (club.isSubbed) {
      //   _subbedClubs.add(club);
      // } else {
      //   _otherClubs.add(club);
      // }
    }
    // _subbedClubs.sort((a, b) {
    //   return a.clubName.toLowerCase().compareTo(b.clubName.toLowerCase());
    // });
    // _otherClubs.sort((a, b) {
    //   return a.clubName.toLowerCase().compareTo(b.clubName.toLowerCase());
    // });
    buildClubsList();
  }

  Future<void> getClubs() async {
    print('Getting Clubs');
    // ignore: omit_local_variable_types
    final LocalStorage localStorage = LocalStorage('iitdapp');
    // var returnObj;
    var timeOutFlag = false;
    final response = await http.get(
      '$url/api/body',
      headers: {'authorization': 'Bearer $token'},
    ).timeout(
      Duration(seconds: 5),
      onTimeout: () async {
        var parsedJson = await localStorage.getItem('clubs');
        handleGetClubsSuccess(parsedJson);
        timeOutFlag = true;
        return null;
      },
    );
    connectedToInternet = !timeOutFlag;
    if (timeOutFlag) {
      return;
    }
    print(response.statusCode);
    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      handleGetClubsSuccess(parsedJson);
      await localStorage.setItem('clubs', parsedJson);
    } else {
      throw Exception('Failed to load clubs');
    }
  }

  void handleGetEventsSuccess(var parsedJson) {
    _allEvents.clear();
    _todayEvents = List<List<Event>>.generate(3, (i) => []);
    _tomorrowEvents = List<List<Event>>.generate(3, (i) => []);
    _upcomingEvents = List<List<Event>>.generate(3, (i) => []);
    // ignore: prefer_collection_literals
    // eventsList = List<Event>();
    // return [_todayEvents, _tomorrowEvents, _upcomingEvents];
    if (parsedJson['message'] == 'Events Found') {
      print(parsedJson['data']['events'].length);
      for (var i = 0; i < parsedJson['data']['events'].length; i++) {
        var ev = Event.fromJson(parsedJson['data']['events'][i]);
        _allEvents.add(ev);
      }
    }
    buildEventsList();
  }

  Future<void> getEvents() async {
    print('Getting Events');
    // ignore: omit_local_variable_types
    final LocalStorage localStorage = LocalStorage('iitdapp');
    var timeOutFlag = false;
    var returnObj;
    final response = await http.get('$url/api/events',
        headers: {'authorization': 'Bearer $token'}).timeout(
      Duration(seconds: 5),
      onTimeout: () async {
        var parsedJson = await localStorage.getItem('events');
        handleGetEventsSuccess(parsedJson);
        timeOutFlag = true;
        return null;
      },
    );
    connectedToInternet = !timeOutFlag;

    if (timeOutFlag) {
      return returnObj;
    }

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Events received');
      var parsedJson = json.decode(response.body);
      handleGetEventsSuccess(parsedJson);
      await localStorage.setItem('events', parsedJson);
    } else {
      throw Exception('Failed to load events');
    }
  }

  void toggleEventStar(String event_id) {
    var event = _allEvents.firstWhere((element) => element.eventid == event_id);
    event.isStarred = !event.isStarred;
    buildEventsList();
  }

  void toggleClubSubscribe(String club_id) {
    var club = _allClubs.firstWhere((element) => element.id == club_id);
    club.isSubbed = !club.isSubbed;
    buildClubsList();
    buildEventsList();
  }

  Future<void> buildClubsList() async {
    _subbedClubs.clear();
    _otherClubs.clear();
    for (var i = 0; i < _allClubs.length; i++) {
      var club = _allClubs[i];
      if (club.isSubbed) {
        _subbedClubs.add(club);
      } else {
        _otherClubs.add(club);
      }
    }
    _subbedClubs.sort((a, b) {
      return a.clubName.toLowerCase().compareTo(b.clubName.toLowerCase());
    });
    _otherClubs.sort((a, b) {
      return a.clubName.toLowerCase().compareTo(b.clubName.toLowerCase());
    });

    notifyListeners();
  }

  void buildEventsList() {
    _todayEvents = List<List<Event>>.generate(3, (i) => []);
    _tomorrowEvents = List<List<Event>>.generate(3, (i) => []);
    _upcomingEvents = List<List<Event>>.generate(3, (i) => []);
    for (var i = 0; i < _allEvents.length; i++) {
      var ev = _allEvents[i];
      var isToday = ((DateTime.now().isAfter(ev.startsAt) &&
              DateTime.now().isBefore(ev.endsAt)) ||
          (DateTime.now().difference(ev.startsAt).inDays == 0 &&
              DateTime.now().day == ev.startsAt.day) ||
          (DateTime.now().difference(ev.endsAt).inDays == 0 &&
              DateTime.now().day == ev.endsAt.day));
      var isTommorow = ((DateTime.now()
                  .add(Duration(days: 1))
                  .isAfter(ev.startsAt) &&
              DateTime.now().add(Duration(days: 1)).isBefore(ev.endsAt)) ||
          (DateTime.now()
                      .add(Duration(days: 1))
                      .difference(ev.startsAt)
                      .inDays ==
                  0 &&
              DateTime.now().add(Duration(days: 1)).day == ev.startsAt.day) ||
          (DateTime.now().add(Duration(days: 1)).difference(ev.endsAt).inDays ==
                  0 &&
              DateTime.now().add(Duration(days: 1)).day == ev.endsAt.day));
      var isUpcoming = (DateTime.now()
              .add(Duration(days: 2))
              .isBefore(ev.endsAt) ||
          (DateTime.now().add(Duration(days: 2)).difference(ev.endsAt).inDays ==
                  0 &&
              DateTime.now().add(Duration(days: 2)).day == ev.endsAt.day));
      if (isToday) {
        if (ev.isStarred) {
          _todayEvents[0].add(ev);
        } else if (_allClubs
            .firstWhere((element) => element.id == ev.eventBody.id)
            .isSubbed) {
          // } else if (ev.isBodySub) {
          _todayEvents[1].add(ev);
        } else {
          _todayEvents[2].add(ev);
        }
      }
      if (isTommorow) {
        if (ev.isStarred) {
          _tomorrowEvents[0].add(ev);
        } else if (_allClubs
            .firstWhere((element) => element.id == ev.eventBody.id)
            .isSubbed) {
          // } else if (ev.isBodySub) {
          _tomorrowEvents[1].add(ev);
        } else {
          _tomorrowEvents[2].add(ev);
        }
      }
      if (isUpcoming) {
        if (ev.isStarred) {
          _upcomingEvents[0].add(ev);
        } else if (_allClubs
            .firstWhere((element) => element.id == ev.eventBody.id)
            .isSubbed) {
          // } else if (ev.isBodySub) {
          _upcomingEvents[1].add(ev);
        } else {
          _upcomingEvents[2].add(ev);
        }
      }
    }
    for (var j = 0; j < 3; j++) {
      _todayEvents[j].sort((a, b) {
        return (a.startsAt != b.startsAt)
            ? a.startsAt.compareTo(b.startsAt)
            : a.eventid.compareTo(b.eventid);
      });
      _tomorrowEvents[j].sort((a, b) {
        return (a.startsAt != b.startsAt)
            ? a.startsAt.compareTo(b.startsAt)
            : a.eventid.compareTo(b.eventid);
      });
      _upcomingEvents[j].sort((a, b) {
        return (a.startsAt != b.startsAt)
            ? a.startsAt.compareTo(b.startsAt)
            : a.eventid.compareTo(b.eventid);
      });
    }

    print('evlistmade');
    print(_todayEvents);
    notifyListeners();
  }
}
