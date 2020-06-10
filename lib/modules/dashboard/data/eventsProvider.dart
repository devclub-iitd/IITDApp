import 'package:IITDAPP/modules/events/events/event_class.dart';
import 'package:IITDAPP/utility/apiHelper.dart';
import 'package:IITDAPP/utility/apiResponse.dart';
import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:flutter/material.dart';

class EventsProvider with ChangeNotifier {
  ApiResponse<List<Event>> upcomingEvents;
  EventsProvider(){
    getUpcomingEvents(false);
  }
  Future<void> getUpcomingEvents([bool refresh = false]) async {
    upcomingEvents = ApiResponse.loading('loading');
    if (refresh) {
      notifyListeners();
    }
    try {
      var response = await apiBaseHelper.get(url + '/api/events/');
      upcomingEvents = ApiResponse.completed(<Event>[...response['data']['events']
              .map((e) => Event.fromJson(e))
              .where((e) =>
                  e.isStarred&&DateTime.now().isBefore(e.endsAt) &&abs(DateTime.now().difference(e.startsAt).inDays) <= 1).toList()]
          );
    notifyListeners();
    } on FetchDataException catch (e) {
      upcomingEvents = ApiResponse.error(e.toString());
    notifyListeners();
    }
  }

  int abs(int i){
    return i<0?-i:i;
  }
}
