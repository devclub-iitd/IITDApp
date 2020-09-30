part of event_calendar;

void getAllEvents(
    var controlEvents, int type, DateTime startTime, DateTime endTime) async {
  print('keep coutning this as well');
  var queryParameters = {
    'startDate': DateFormat('yyyy-MM-ddTHH:mm:ss').format(startTime) + '.000Z',
    'endDate': DateFormat('yyyy-MM-ddTHH:mm:ss').format(endTime) + '.000Z'
  };
  var response = await http.post('$url/api/calendar/all/',
      headers: {'authorization': 'Bearer $token'}, body: queryParameters);
  if (response.statusCode != 200) {
    return;
  }
  await getEventsFromResponse(
      jsonDecode(response.body)['data']
          [type == 0 ? 'staredEvents' : 'reminders'],
      controlEvents,
      type);
}

Future<int> deleteReminderFromServer(var eventId,
    {bool addToQueue = true}) async {
  var prefs = await SharedPreferences.getInstance();
  var keys = prefs.getKeys();
  var success = 1;
  try {
    keys.forEach((element) async {
      if (prefs.getString(element) == 'loc ' + eventId) {
        var res = await http.delete(
            '$url/api/calendar/reminder/' + element.substring(4),
            headers: {
              'authorization': 'Bearer $token'
            }).timeout(Duration(seconds: 5), onTimeout: () async {
          success = -1;
          connectedToInternet = false;
          if (addToQueue) {
            QueueManager.addToList(
                {'func': 'deleteReminderFromServer', 'eventId': eventId});
          }
          return null;
        });
        if (res.statusCode != 200) {
          success = 0;
        }
        if(res.statusCode==200){
          await prefs.remove(element);
        }
        return;
      }
    });
  } catch (e) {
    print(e);
  }
  return success;
}

searchItemFromLocal(var controlEvents,serverItem,var type){
  var res = '';
  controlEvents.data.forEach((data){
    if(checkEquality(data, serverItem, type)){
      res = data.eventId;
    }
  });
  return res;
}

Future<void> getEventsFromResponse(
    var rems, var controlEvents, var type) async {
  // ignore: omit_local_variable_types
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var serKeys = <String>[];
  var allKeys = await prefs.getKeys();
  await allKeys.forEach((element) async {
    if(element.startsWith('ser')) {
      serKeys.add(element);
    }
  });
  await rems.forEach((data) async {
    var item = await prefs.getString('ser ' + data['_id']);
    serKeys.remove('ser '+data['_id']);
    print('ok type ${type}');
    item = item != null ? item.substring(4) : item;
    if (item == null) {
      var localId = searchItemFromLocal(controlEvents, data, type);
      if(localId!=''){
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString('ser ' + data['_id'], 'loc ' + localId);
      }
      else {
        print('adding ev');
        await getEventObject(data, '', type);
      }
    } else {
      controlEvents.data.forEach((data2) {
        if (data2.eventId == item) {
          var equal = checkEquality(data2, data,type);
          if (!equal) {
            print('the given event is not equal to its counterpart ${data2.title}');
            getEventObject(data, item, type);
          }
        }
      });
    }
  });
  if(type==1) {
    serKeys.forEach((element) async {
      var eventId = await prefs.getString(element).substring(4);
      var deleteEv = false;
      await controlEvents.data.forEach((ev) {
        if(ev.eventId == eventId){
          deleteEv = true;
        }
      });
      if(deleteEv) {
        var res = await DeviceCalendarPlugin().deleteEvent(
            userEventsCalendarId, eventId);
        print('deleted ${res} with event id ${eventId}');
        if (res.isSuccess) {
          await prefs.remove(element);
        }
      }
    });
  }
}

bool checkEquality(var localItem, var serverItem,var type) {
  if (localItem.title != serverItem['name']) {
    return false;
  }
    String temp = serverItem['startDate'].substring(0,serverItem['startDate'].indexOf('T'))+' '+serverItem['startDate'].substring(serverItem['startDate'].indexOf('T')+1,serverItem['startDate'].indexOf('Z')-0);
    if(localItem.start != DateTime.parse(temp)) {
      return false;
    }
    temp = serverItem['endDate'].substring(0,serverItem['endDate'].indexOf('T'))+' '+serverItem['endDate'].substring(serverItem['endDate'].indexOf('T')+1,serverItem['endDate'].indexOf('Z')-0);
    if(localItem.end != DateTime.parse(temp)) {
      return false;
    }
  if (!(localItem.attendees.isEmpty && getAttendeeListFromList(serverItem['participants']).isEmpty) && (localItem.attendees !=
      getAttendeeListFromList(serverItem['participants']))) {
    return false;
  }
  if (localItem.location != null &&
      localItem.location != serverItem['venue']) {
    return false;
  }

  /*** Uncomment this once backend is fixed ***/
  if(type==1) {
    if (localItem.description != null &&
        localItem.description != serverItem['description']) {
      return false;
    }
//  if(localItem.url!=serverItem['url']) {
//    return false;
//  }
    if (!(localItem.reminders.isEmpty && getReminderList(serverItem['reminder']).isEmpty)&&(localItem.reminders != getReminderList(serverItem['reminder']))) {
      return false;
    }
    if (localItem.recurrenceRule != null && localItem.recurrenceRule != getRecurrenceString(serverItem['recurrence'])) {
      return false;
    }
  }
  else{
    if (localItem.description != null &&
        localItem.description != serverItem['about']) {
      return false;
    }
  }
  return true;
}

Future<void> getEventObject(var data, var eventId, var type) async {
  // ignore: omit_local_variable_types
  // final LocalStorage ls = LocalStorage('IITDAPP Calendar');
  Event event;
    event = Event(type==1?userEventsCalendarId:starredCalendarId,
        start: DateTime.parse(data['startDate']),
        end: DateTime.parse(data['endDate']));
  if (eventId != '') {
    event.eventId = eventId;
  }

  event.title = data['name'];
  /**** Uncomment the following lines once the backend has been updated ****/
  event.location = data['venue'];
  event.attendees = getAttendeeListFromList(data['participants']);
  if(type==1) {
    event.description = data['description'];
    event.reminders = getReminderList(data['reminder']);
    event = addRecurrenceRule(data['recurrence'], event);
  }
  else{
    event.description = data['about'];
  }
  event.allDay = false;
  // event.availability = Availibility.B//'BUSY';
  makeEventElementsNonNull(event);
  var res = await DeviceCalendarPlugin().createOrUpdateEvent(event);
  if (res.isSuccess) {
    var meetings = <Meeting>[];
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('ser ' + data['_id'], 'loc ' + res.data);
    meetings.add(Meeting(
      eventId: res.data,
      isAllDay: event.allDay,
      eventName: event.title,
      from: event.start,
      to: event.end,
      calendarId: type == 1 ? userEventsCalendarId : starredCalendarId,
      background: Color(-30000), //colorCollection[_selectedColorIndex],
      startTimeZone: '',
      endTimeZone: '',
      /**** Uncomment the following lines once the backend has been updated ****/
      location: event.location,
      attendee: event.attendees,
      recurrence: event.recurrenceRule,
      reminder: event.reminders,
      description: event.description,
    ));
    print(meetings);
    _events.appointments.add(meetings[0]);

    _events.notifyListeners(CalendarDataSourceAction.add, <Meeting>[]..add(meetings[0]));
  } else {
    print('error occured');
  }
  return;
}

Future<String> getServerIdFromPrefs(var id) async{
  var prefs = await SharedPreferences.getInstance();
  var keys = prefs.getKeys();
  var res = '';
  keys.forEach((element) async {
    if (prefs.getString(element) == 'loc ' + id) {
      res = element.substring(4);
      return null;
    }
  });
  print('to be exec 1');
  return res;

}

Future<String> getServerId(var eventId) async {
  var prefs = await SharedPreferences.getInstance();
  var ans = '';
  var keys = prefs.getKeys();
  keys.forEach((element) {
    if (element == eventId) {
      ans = element;
      return;
    }
  });
  return ans;
}

Map<String, String> createPostReminderBody(Event ev){
  return {
    'name': ev.title,
    'startDate': DateFormat('yyyy-MM-ddTHH:mm:ss').format(ev.start) + '.000Z',
    'endDate': DateFormat('yyyy-MM-ddTHH:mm:ss').format(ev.end) + '.000Z',
    'description': ev.description,
    'reminder': getReminderString(ev.reminders),
    'repeat': getRecurrenceString(ev.recurrenceRule),
    'participants': getAttendeeString(ev.attendees),
    'venue': ev.location,
    'url': ''   // check this
  };
}

Future<String> postReminder(Event ev, bool patch,
    {var body, bool addToQueue = true}) async {
  body ??= createPostReminderBody(ev);
  if(body['url']==null){
    body['url'] = '';
  }
  var response;
  var flagTimeout = false;
  if (patch) {
    // this will not work until backend is fixed
//    try {
          var serverId = await getServerIdFromPrefs(ev.eventId);
          print('to be exec 2');
          response = await http
              .patch('$url/api/calendar/reminder/' + serverId,
                  headers: {'authorization': 'Bearer $token'}, body: body)
              .timeout(Duration(seconds: 5), onTimeout: () async {
            flagTimeout = true;
            return null;
          });

//    } catch (e) {
//      flagTimeout = true;
//      print(e);
//    }
  } else {
    try {
      response = await http
          .post('$url/api/calendar/reminder/',
              headers: {'authorization': 'Bearer $token'}, body: body)
          .timeout(Duration(seconds: 5), onTimeout: () {
        flagTimeout = true;
        return null;
      });
    } catch (e) {
      flagTimeout = true;
      print(e);
    }
  }
  if (flagTimeout) {
    connectedToInternet = false;
    if (addToQueue) {
      QueueManager.addToList(
          {'func': 'postReminder', 'event': body, 'patch': patch,'eventId': ev!=null?ev.eventId:''});
    }
    return 'timeout';
  }

  if (response.statusCode != 200) {
    return 'error';
  }
  if (patch) {
    return '';
  }
  return jsonDecode(response.body)['data']['_id'];
}
