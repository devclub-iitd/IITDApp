
part of event_calendar;

void getAllEvents(var controlEvents,int type,DateTime startTime,DateTime endTime) async {
  var queryParameters = {
    'startTime': DateFormat('yyyy-MM-ddTHH:mm:ss').format(startTime)+'.000Z',
    'endTime':  DateFormat('yyyy-MM-ddTHH:mm:ss').format(endTime)+'.000Z'
  };
  var response = await http.post('$url/api/calendar/all/',
    headers: {'authorization': 'Bearer $token'},
      body: queryParameters);
  if(response.statusCode!=200) {
    return;
  }
  await getEventsFromResponse(jsonDecode(response.body)['data'][type==0?'staredEvents':'reminders'],controlEvents,type);
}

Future<int> deleteReminderFromServer(var eventId) async {
  var prefs = await SharedPreferences.getInstance();
  var keys = prefs.getKeys();
  var success = 1;
  keys.forEach((element) async {
    if(prefs.getString(element)==eventId){
      var res = await http.delete('$url/api/calendar/reminder/'+element,
        headers: {'authorization': 'Bearer $token'}).timeout(
          Duration(seconds: 5),
          onTimeout: () async {
            success = -1;
            connectedToInternet = false;
            QueueManager.addToList({'func': 'deleteReminderFromServer','eventId': eventId});
            return null;
        });
      if(res.statusCode!=200) {
        success = 0;
      }
    }
  });
  return success;
}

Future<void> getEventsFromResponse(var rems,var controlEvents,var type) async {
  // ignore: omit_local_variable_types
  SharedPreferences prefs = await SharedPreferences.getInstance();

  rems.forEach((data) async {
    var item = await prefs.getString('ser '+data['_id']);
    item = item!=null?item.substring(4):item;
    if(item==null){
      getEventObject(data,'',type);
    }
    else{
      controlEvents.data.forEach((data2){
        if(data2.eventId==item){
          var equal = checkEquality(data2, data);
          if(!equal){
            getEventObject(data, item,type);
          }
        }
      });
    }
  });
}

bool checkEquality(var localItem,var serverItem){
  if(localItem.title!=serverItem['title']) {
    return false;
  }
  if(localItem.start.toUtc()!=DateTime.parse(serverItem['startTime'])) {
    return false;
  }
  if(localItem.end.toUtc()!=DateTime.parse(serverItem['endTime'])) {
    return false;
  }
  /*** Uncomment this once backend is fixed ***/
//  if(localItem.description!=null && localItem.description!=serverItem['description']) {
//    return false;
//  }
//  if(localItem.location!=null && localItem.location!=serverItem['location']) {
//    return false;
//  }
//  if(localItem.url!=serverItem['url']) {
//    return false;
//  }
//  if(localItem.attendees!=getAttendeeList(serverItem['attendees'])) {
//    return false;
//  }
//  if(localItem.reminders!=getReminderList(serverItem['reminder'])) {
//    return false;
//  }
//  if(localItem.recurrenceRule!=null && localItem.recurrenceRule!=getRecurrenceString(serverItem['recurrence'])) {
//    return false;
//  }
  return true;
}

Future<void> getEventObject(var data,var eventId,var type) async {
  // ignore: omit_local_variable_types
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // final LocalStorage ls = LocalStorage('IITDAPP Calendar');
  var event = Event(
      userEventsCalendarId,
    start: DateTime.parse(data['startTime']),
    end: DateTime.parse(data['endTime'])
  );
  if(eventId!='') {
    event.eventId = eventId;
  }
  event.title = data['title'];
  /**** Uncomment the following lines once the backend has been updated ****/
//  event.description = data['description'];
//  event.location = data['location'];
//  event.attendees = getAttendeeList(data['participants']);
//  event.reminders = getReminderList(data['reminder']);
//  event = addRecurrenceRule(data['recurrence'], event);
  event.allDay = false;
  var res = await DeviceCalendarPlugin().createOrUpdateEvent(event);
  if (res.isSuccess) {
    var meetings = <Meeting>[];
    await prefs.setString('ser '+data['_id'], 'loc '+ res.data);
    meetings.add(Meeting(
      eventId: res.data,
      isAllDay: event.allDay,
      eventName: event.title,
      from: event.start,
      to: event.end,
      calendarId: type == 1
          ? userEventsCalendarId
          : starredCalendarId,
      background: Color(
          _selectedColor), //colorCollection[_selectedColorIndex],
      startTimeZone: '',
      endTimeZone: '',
      /**** Uncomment the following lines once the backend has been updated ****/
//      location: event.location,
//      attendee: event.attendees,
//      recurrence: event.recurrenceRule,
//      reminder: event.reminders,
//      description: event.description,
    ));
    print(meetings);
    _events.appointments.add(meetings[0]);

    _events.notifyListeners(
        CalendarDataSourceAction.add, meetings);
  } else {
    print('error occured');
  }
  return ;
}

Future<String> getServerId(var eventId) async {
  var prefs = await SharedPreferences.getInstance();
  var ans = '';
  var keys = prefs.getKeys();
  keys.forEach((element) {
    if(element==eventId) {
      ans = element;
      return;
    }
  });
  return ans;
}

Future<String> postReminder(Event ev,bool patch,{var body}) async{
  body ??= {
      'title': ev.title,
      'startTime': DateFormat('yyyy-MM-ddTHH:mm:ss').format(ev.start) + '.000Z',
      'endTime': DateFormat('yyyy-MM-ddTHH:mm:ss').format(ev.end) + '.000Z'
      /**** Uncomment this *****/
//    ,
//    'description': ev.description,
//    'reminders': getReminderString(ev.reminders),
//    'recurrence': getRecurrenceString(ev.recurrenceRule),
//    'attendees': getAttendeeString(ev.attendees),
//    'location': ev.location,
//    'url': ev.url,
    };
  var response;
  var flagTimeout = false;
  if(patch){  // this will not work until backend is fixed
    response = await http.patch('$url/api/calendar/reminder/',
        headers: {'authorization': 'Bearer $token'},
        body: body).timeout(Duration(seconds: 5),
        onTimeout: (){
          flagTimeout = true;
          return null;
        });
  }
  else {
    response = await http.post('$url/api/calendar/reminder/',
        headers: {'authorization': 'Bearer $token'},
        body: body).timeout(Duration(seconds: 5),
    onTimeout: (){
          flagTimeout = true;
          return null;
    });
  }
  if(flagTimeout) {
    connectedToInternet = false;
    QueueManager.addToList({'func': 'postReminder','event': body,'patch': patch});
    return 'timeout';
  }
  if(response.statusCode!=200){
    return 'error';
  }
  if(patch) {
    return '';
  }
  return jsonDecode(response.body)['data']['_id'];
}