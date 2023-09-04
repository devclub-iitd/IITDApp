import 'package:flutter/material.dart';
import 'package:iitd_app/core/apiservices.dart';
import 'package:iitd_app/models/eventsmodel.dart';
import 'package:iitd_app/models/lostandfoundmodel.dart';
import 'package:iitd_app/utils/constants.dart';

class EventState extends ChangeNotifier {
  final EventsAPI _eventsAPI = EventsAPI();
  late List<EventsModel> eventsList;
  late EventsListStatus eventsListStatus = EventsListStatus.loading;

  Future fetchEvents(String clubID) async {
    try {
      eventsListStatus = EventsListStatus.loading;
      final fetchedEventsList = await _eventsAPI.fetchAllEvents(clubID);
      eventsList = fetchedEventsList;

      notifyListeners();
      eventsListStatus = EventsListStatus.loaded;
    } catch (e) {
      eventsListStatus = EventsListStatus.error;
    }
  }
}

class LostAndFoundState extends ChangeNotifier {
  final LostAndFoundAPI _lostandfoundAPI = LostAndFoundAPI();
  late List<LostandFoundModel> lostandfoundList;
  late LostAndFoundListStatus lostandfoundListStatus =
      LostAndFoundListStatus.loading;

  Future fetchLostAndFound() async {
    try {
      lostandfoundListStatus = LostAndFoundListStatus.loading;
      final fetchedLostAndFoundList =
          await _lostandfoundAPI.fetchAllLostAndFound();
      lostandfoundList = fetchedLostAndFoundList;

      lostandfoundListStatus = LostAndFoundListStatus.loaded;
      notifyListeners();
    } catch (e) {
      lostandfoundListStatus = LostAndFoundListStatus.error;
      notifyListeners();
    }
  }
}
