import 'package:IITDAPP/modules/events/clubs/club_class.dart';

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
    // this.updates
  }) {
      startsAt = (start == null)? DateTime.now():start;
      endsAt = (end == null)? startsAt.add(Duration(days: 1)):end;
  }

  factory Event.fromJson(Map<String,dynamic> json) {
    // DateTime startDate = DateTime.parse(json["startDate"]).add(Duration(days: 2));
    var startDate = DateTime.parse(json['startDate']);
    var endDate = (json.containsKey('endDate')) ? DateTime.parse(json['endDate']) : startDate.add(Duration(hours: 1));
    return Event(
      eventName: json['name'], //
      eventBody: Club.fromJson(json['body']), //
      imageLink: json.containsKey('image') ? json['image'] : '',
      start: startDate, //
      end: endDate,
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
    map['imageLink'] = imageLink;
    return map;
  }

  Map toMapForUpdate() {
    var map = <String, dynamic>{};
    map['name'] = eventName;
    map['about'] = about;
    map['startDate'] = startsAt.toIso8601String();
    map['endDate'] = endsAt.toIso8601String();
    map['venue'] = venue;
    map['imageLink'] = imageLink;
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
