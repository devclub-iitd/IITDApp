import 'package:IITDAPP/modules/events/events/event_class.dart';
import 'package:IITDAPP/utility/apiHelper.dart';
import 'package:IITDAPP/utility/apiResponse.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/material.dart';

class EventsProvider with ChangeNotifier {
  ApiResponse<List<Event>> upcomingEvents;
  EventsProvider() {
    getUpcomingEvents(false);
  }
  Future<void> getUpcomingEvents([bool refresh = false]) async {
    upcomingEvents = ApiResponse.loading('loading');
    if (refresh) {
      notifyListeners();
    }
    try {
      var response = await apiBaseHelper.get(uri + '/api/events/');
      upcomingEvents = ApiResponse.completed(<Event>[
        ...response['data']['events']
            .map((e) => Event.fromJson(e))
            .where((e) =>
                (e.isStarred || e.eventBody.isSubbed) &&
                DateTime.now().isBefore(e.endsAt) &&
                abs(DateTime.now().difference(e.startsAt).inDays) <= 1)
            .toList()
      ]);
      // Now sort the events such that starred events are at the top
      upcomingEvents.data.sort((a, b) => a.isStarred ? -1 : 1);
      notifyListeners();
    } on FetchDataException catch (e) {
      upcomingEvents = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  int abs(int i) {
    return i < 0 ? -i : i;
  }
}
