// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:iitd_app/models/clubmodel.dart';
import 'package:iitd_app/utils/constants.dart';

class EventsModel {
  String eventid;
  String eventName;
  Club? eventBody;
  String venue;
  DateTime? startsAt;
  DateTime? endsAt;
  String about;
  String? imageLink;
  // bool isStarred;
  // bool isSub;
  String bodyid;

  EventsModel({
    required this.eventid,
    required this.eventName,
    this.eventBody,
    required this.venue,
    required this.about,
    this.startsAt,
    this.endsAt,
    this.imageLink,
    // this.isStarred = false,
    // this.isSub = false,
    required this.bodyid,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    var startDate = DateTime.parse(json['startDate']);
    var endDate = (json.containsKey('endDate'))
        ? DateTime.parse(json['endDate'])
        : startDate.add(const Duration(hours: 1));

    return EventsModel(
        eventName: json['name'],
        eventBody: Club(
            clubName: json['body']['name'],
            clubAbout: json['body']['about'],
            isSubbed: json['body']['isSub'],
            id: json['body']['id']),
        startsAt: startDate.toLocal(),
        endsAt: endDate.toLocal(),
        imageLink: "${EndPoints.baseURL}/${json['image']}",
        about: json['about'],
        venue: json['venue'],
        eventid: json['id'],
        bodyid: json['body']['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'eventid': eventid,
      'eventName': eventName,
      'eventBody': eventBody?.toJson(), // Convert Club object to JSON
      'venue': venue,
      'startsAt': startsAt?.toIso8601String(), // Convert DateTime to ISO 8601 string
      'endsAt': endsAt?.toIso8601String(),
      'about': about,
      'imageLink': imageLink,
      'bodyid': bodyid,
    };
  }
}
