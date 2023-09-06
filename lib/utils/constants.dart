import 'dart:convert';

import 'package:iitd_app/models/eventsmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool guest = false;
String token = "";

enum EventsListStatus {
  loading,
  loaded,
  error,
}

enum LostAndFoundListStatus {
  loading,
  loaded,
  error,
}

enum LostandFoundStatus { claimed, unclaimed }

class EndPoints {
  EndPoints._();

  static const String baseURL = 'https://iitdconnect-server.devclub.in';

  //* Events API Endpoints
  static const String fetchEvents = '$baseURL/api/web/events';
  static const String fetchNews = "$baseURL/api/web/news";

  //* Lost and Found API Endpoints
  static const String fetchLostAndFound = '$baseURL/api/lostfound';
}

List<EventsModel> likedevents = [];

Future<void> loadData() async {
  final prefs = await SharedPreferences.getInstance();
  final storedData = prefs.getStringList('likedevents');
  likedevents.clear();
  if (storedData != null) {
    for (String jsonString in storedData) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      likedevents.add(EventsModel.fromJson(json));
    }
  }
}
