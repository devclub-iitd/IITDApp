import 'package:IITDAPP/modules/events/clubs/club_class.dart';
import 'dart:io';

import 'package:http/http.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';
import '../events/event_class.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'dart:convert';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/cancel_alert.dart';
import 'package:IITDAPP/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pedantic/pedantic.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;
import 'package:IITDAPP/values/Constants.dart';

class Event {
  String eventName;
  Club eventBody;
  String venue = 'LHC';
  DateTime startsAt;
  DateTime endsAt;
  String about;
  String imageLink;
  bool isStarred;
  bool isBodySub;
  String bodyid;
  String eventid;
  File eventImage;
  // List<Update> updates;

  Event({
    this.eventName,
    this.eventBody,
    this.venue,
    this.about,
    DateTime start,
    DateTime end,
    this.bodyid,
    this.eventid,
    this.isStarred = false,
    this.isBodySub = false,
    this.imageLink = '',
    this.eventImage,
    // this.updates
  }) {
    startsAt = (start == null) ? DateTime.now() : start;
    endsAt = (end == null) ? startsAt.add(Duration(days: 1)) : end;
  }

  static Future<File> imgtofile(String url) async {
    print(url);
    final http.Response responseData = await http.get(url);
    var uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/img').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    print(json);
    // DateTime startDate = DateTime.parse(json["startDate"]).add(Duration(days: 2));
    var startDate = DateTime.parse(json['startDate']);
    var endDate = (json.containsKey('endDate'))
        ? DateTime.parse(json['endDate'])
        : startDate.add(Duration(hours: 1));

    return Event(
        eventName: json['name'], //
        eventBody:
            // Club.fromJson(json['body']), //
            Club(
                clubName: json['body']['name'],
                clubAbout: json['body']['about'],
                isSubbed: json['body']['isSub'],
                // clubDept: json["dept"],
                id: json['body']['id']),
        start: startDate, //
        end: endDate,
        // eventImage: imgtofile("$uri/${json['image']}"),
        // updates: json["updates"],
        about: json['about'], //
        venue: json['venue'], //
        isStarred: json['stared'], //
        eventid: json['id'], //
        isBodySub: json['body']['isSub'] //
        );
  }

  Map toMap() {
    var map = <String, dynamic>{};
    map['name'] = eventName;
    map['about'] = about;
    map['startDate'] = startsAt.toIso8601String() + 'Z';
    map['endDate'] = endsAt.toIso8601String() + 'Z';
    map['venue'] = venue;
    map['body'] = eventBody.id;
    // map['eventImage'] = eventImage;
    return map;
  }

  Map toMapForUpdate() {
    var map = <String, dynamic>{};
    map['name'] = eventName;
    map['about'] = about;
    map['startDate'] = startsAt.toIso8601String();
    map['endDate'] = endsAt.toIso8601String();
    map['venue'] = venue;
    // map['eventImage'] = eventImage;
    return map;
  }
}

// var dummyEvent1 = Event(
//     eventName: 'Event1',
//     eventBody: DummyClub,
//     venue: 'LHC',
//     about: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
//     isStarred: false,
//     isBodySub: false);

// var dummyEvent2 = Event(
//     eventName: 'Campus Hackathon',
//     eventBody: 'DevClub',
//     venue: 'LT6 Block-II',
//     about: 'jhkbj',
//     isStarred: true,
//     isBodySub: false);

// var dummyEvent3 = Event(
//     eventName: 'Event3',
//     eventBody: 'Club1',
//     venue: 'LHrwebferbgeberbergergererrbfC',
//     about: 'jhkbj',
//     isStarred: true,
//     isBodySub: false);

// var dummyEvent4 = Event(
//     eventName: 'Event4',
//     eventBody: 'Club1',
//     venue: 'LHC',
//     about: 'jhkbj',
//     isStarred: true,
//     isBodySub: false);

// var dummyEvent5 = Event(
//     eventName: 'Event5',
//     eventBody: 'Club1',
//     venue: 'LHC',
//     about: 'jhkbj',
//     isStarred: true,
//     isBodySub: true);

// var dummyEvent6 = Event(
//     eventName: 'Event6',
//     eventBody: 'Club1',
//     venue: 'LHC',
//     about: 'jhkbj',
//     isStarred: true,
//     isBodySub: true);

// var dummyEvent7 = Event(
//     eventName: 'Event7',
//     eventBody: 'Club1',
//     venue: 'LHC',
//     about: 'jhkbj',
//     isStarred: false,
//     isBodySub: false);

// var dummyEvent8 = Event(
//     eventName: 'Event8',
//     eventBody: 'Club1',
//     venue: 'LHC',
//     about: 'jhkbj',
//     isStarred: false,
//     isBodySub: false);

// var dummyEvent9 = Event(
//     eventName: 'Event9',
//     eventBody: 'Club1',
//     venue: 'LHC',
//     about: 'jhkbj',
//     isStarred: false,
//     isBodySub: false);

// var dummyEvent10 = Event(
//     eventName: 'Event10',
//     eventBody: 'Club1',
//     venue: 'LHC',
//     about: 'jhkbj',
//     isStarred: false,
//     isBodySub: false);

// var dummyEvent11 = Event(
//     eventName: 'Dance Competition',
//     eventBody: 'Dance Club',
//     venue: 'Seminar Hall',
//     about: 'jhkbj',
//     isStarred: false,
//     isBodySub: true);

// var dummyEvent12 = Event(
//     eventName: 'Paint Job',
//     eventBody: 'Fine Arts Club',
//     venue: 'LHC',
//     about: 'jhkbj',
//     isStarred: false,
//     isBodySub: true);

// var dummyEvent13 = Event(
//     eventName: 'Street Play',
//     eventBody: 'Dramatics Society',
//     venue: 'SAC Lawns',
//     about: 'jhkbj',
//     isStarred: false,
//     isBodySub: true);

// var dummyEvent14 = Event(
//     eventName: 'Event14',
//     eventBody: 'Club1',
//     venue: 'LHC',
//     about: 'jhkbj',
//     isStarred: false,
//     isBodySub: false);

// var dummyEvent15 = Event(
//     eventName: 'Event15',
//     eventBody: 'Club1',
//     venue: 'LHC',
//     about: 'jhkbj',
//     isStarred: false,
//     isBodySub: false);

// var dummyEvent16 = Event(
//     eventName: 'Event16',
//     eventBody: 'Club1',
//     venue: 'LHC',
//     about: 'jhkbj',
//     isStarred: false,
//     isBodySub: false);

// List<Event> starEvents = [dummyEvent2,dummyEvent3,dummyEvent4,dummyEvent5,dummyEvent6];
// List<Event> subbedEvents = [dummyEvent11,dummyEvent12,dummyEvent13];
// List<Event> otherEvents = [dummyEvent1,dummyEvent7,dummyEvent8,dummyEvent9,dummyEvent10,dummyEvent14,dummyEvent15,dummyEvent16];

// List<List<Event>> events = [starEvents, subbedEvents, otherEvents];
