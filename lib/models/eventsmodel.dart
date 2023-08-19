import 'package:iitd_app/models/clubmodel.dart';

class EventsModel {
  String eventid;
  String eventName;
  Club? eventBody;
  String venue;
  DateTime? startsAt;
  DateTime? endsAt;
  String about;
  String imageLink;
  bool isStarred;
  bool isSub;
  //String bodyid;

  EventsModel({
    required this.eventid,
    required this.eventName,
    this.eventBody,
    required this.venue,
    required this.about,
    this.startsAt,
    this.endsAt,
    this.imageLink = '',
    this.isStarred = false,
    this.isSub = false,
    //this.bodyid,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    var startDate = DateTime.parse(json['startDate']);
    var endDate = (json.containsKey('endDate'))
        ? DateTime.parse(json['endDate'])
        : startDate.add(const Duration(hours: 1));
    return EventsModel(
        eventName: json['name'], //
        eventBody: Club(
            clubName: json['body']['name'],
            clubAbout: json['body']['about'],
            isSubbed: json['body']['isSub'],
            // clubDept: json["dept"],
            id: json['body']['id']),
        startsAt: startDate.toLocal(), //
        endsAt: endDate.toLocal(),
        // eventImage: imgtofile("$uri/${json['image']}"),
        // updates: json["updates"],
        about: json['about'], //
        venue: json['venue'], //
        isStarred: json['stared'], //
        eventid: json['id'], //
        isSub: json['body']['isSub'] //
        );
  }
}
