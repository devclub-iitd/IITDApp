import 'package:flutter/material.dart';
import 'package:iitd_app/core/apiservices.dart';
import 'package:iitd_app/models/eventsmodel.dart';
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
