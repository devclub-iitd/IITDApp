import 'package:flutter/material.dart';

import 'events/event_class.dart';
import 'clubs/club_class.dart';


List<Event> eventsList;

List<List<Event>> todayEvents = List<List<Event>>.generate(3, (i) => []);
List<List<Event>> tomorrowEvents = List<List<Event>>.generate(3, (i) => []);
List<List<Event>> upcomingEvents = List<List<Event>>.generate(3, (i) => []);


List<Club> subbedClubs = List<Club>();
List<Club> otherClubs = List<Club>();
List<Club> allClubs = List<Club>();

Future<List<List<List<Event>>>> sortEvents() async {
  todayEvents = List<List<Event>>.generate(3, (i) => []);
  tomorrowEvents = List<List<Event>>.generate(3, (i) => []);
  upcomingEvents = List<List<Event>>.generate(3, (i) => []);
  for (int i = 0; i < eventsList.length; i++) {
    var ev = eventsList[i];
    var isToday = ((DateTime.now().isAfter(ev.startsAt) &&
            DateTime.now().isBefore(ev.endsAt)) ||
        (DateTime.now().difference(ev.startsAt).inDays == 0 &&
            DateTime.now().day == ev.startsAt.day) ||
        (DateTime.now().difference(ev.endsAt).inDays == 0 &&
            DateTime.now().day == ev.endsAt.day));
    var isTommorow = ((DateTime.now()
                .add(Duration(days: 1))
                .isAfter(ev.startsAt) &&
            DateTime.now().add(Duration(days: 1)).isBefore(ev.endsAt)) ||
        (DateTime.now().add(Duration(days: 1)).difference(ev.startsAt).inDays ==
                0 &&
            DateTime.now().add(Duration(days: 1)).day == ev.startsAt.day) ||
        (DateTime.now().add(Duration(days: 1)).difference(ev.endsAt).inDays ==
                0 &&
            DateTime.now().add(Duration(days: 1)).day == ev.endsAt.day));
    var isUpcoming =
        (DateTime.now().add(Duration(days: 2)).isBefore(ev.endsAt) || (DateTime.now().add(Duration(days: 2)).difference(ev.endsAt).inDays ==
                0 &&
            DateTime.now().add(Duration(days: 2)).day == ev.endsAt.day));
    if (isToday) {
      if (ev.isStarred) {
        todayEvents[0].add(ev);
      } else if (ev.isBodySub) {
        todayEvents[1].add(ev);
      } else {
        todayEvents[2].add(ev);
      }
    }
    if (isTommorow) {
      if (ev.isStarred) {
        tomorrowEvents[0].add(ev);
      } else if (ev.isBodySub) {
        tomorrowEvents[1].add(ev);
      } else {
        tomorrowEvents[2].add(ev);
      }
    }
    if (isUpcoming) {
      if (ev.isStarred) {
        upcomingEvents[0].add(ev);
      } else if (ev.isBodySub) {
        upcomingEvents[1].add(ev);
      } else {
        upcomingEvents[2].add(ev);
      }
    }
  }
  for (var j = 0; j < 3; j++) {
    todayEvents[j].sort((a, b) {
      return (a.startsAt != b.startsAt)
          ? a.startsAt.compareTo(b.startsAt)
          : a.eventid.compareTo(b.eventid);
    });
    tomorrowEvents[j].sort((a, b) {
      return (a.startsAt != b.startsAt)
          ? a.startsAt.compareTo(b.startsAt)
          : a.eventid.compareTo(b.eventid);
    });
    upcomingEvents[j].sort((a, b) {
      return (a.startsAt != b.startsAt)
          ? a.startsAt.compareTo(b.startsAt)
          : a.eventid.compareTo(b.eventid);
    });
  }
  return [todayEvents, tomorrowEvents, upcomingEvents];
}



// void refreshLists(Event event) {
//   bool isToday = (DateTime.now().difference(event.startsAt).inDays >= 0 &&
//       DateTime.now().difference(event.endsAt).inDays <= 0);
//   bool isTommorow = (DateTime.now()
//               .add(Duration(days: 1))
//               .difference(event.startsAt)
//               .inDays >=
//           0 &&
//       DateTime.now().add(Duration(days: 1)).difference(event.endsAt).inDays <=
//           0);
//   bool isUpcoming =
//       (DateTime.now().add(Duration(days: 1)).difference(event.endsAt).inDays <
//           0);
//   if (isToday) _refreshList(todayEvents, event);
//   if (isTommorow) _refreshList(tomorrowEvents, event);
//   if (isUpcoming) _refreshList(upcomingEvents, event);
// }

// void _refreshList(List<List<Event>> list, Event event) {
//   if (event.isStarred) {
//     list[0].add(event);
//     if (event.isBodySub) {
//       var tempev = list[1].firstWhere((eve) => eve.eventid == event.eventid);
//       list[1].remove(tempev);
//     } else {
//       var tempev = list[2].firstWhere((eve) => eve.eventid == event.eventid);
//       list[2].remove(tempev);
//     }
//   } else {
//     var tempev = list[0].firstWhere((eve) => eve.eventid == event.eventid);
//     list[0].remove(tempev);
//     if (event.isBodySub) {
//       list[1].add(event);
//     } else {
//       list[2].add(event);
//     }
//   }
//   for (int j = 0; j < 3; j++) {
//     list[j].sort((a, b) {
//       return a.startsAt.compareTo(b.startsAt);
//     });
//   }
// }
