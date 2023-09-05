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
  // static const String getAllEvents = '$baseURL/api/events';
  // static const String getStarredEvents = '$baseURL/events/starred';

  //* Lost and Found API Endpoints
  static const String fetchLostAndFound = '$baseURL/api/lostfound';
}

List<EventsModel> likedevents = [];

Future<void> loadData() async {
  final prefs = await SharedPreferences.getInstance();
  final storedData = prefs.getString('likedevents');

  if (storedData != null) {
    final List<dynamic> jsonList = jsonDecode(storedData);
    print(jsonList);
    likedevents = jsonList.map((json) => EventsModel.fromJson(json)).toList();
  }
}
