part of event_calendar;

DataSource filterEvents(var calendarModel,var exempted) {
  var res = [];
  calendarModel.forEach((data) {
    if(exempted[data.name]==null || !exempted[data.name]) {
      res.add(data.events.data);
    }
  });
  return mapToCalDataSource(res);
}

DataSource mapToCalDataSource(var res) {
  // ignore: omit_local_variable_types
  final List<Meeting> meetingCollection = <Meeting>[];
  eventNameCollection = <String>[];
  res.forEach((data1) {
    data1.forEach((data2) {
      meetingCollection.add(Meeting(
        from: data2.start,
        to: data2.end,
        eventName: data2.title,
        description: data2.description,
        isAllDay: data2.allDay,
        calendarId: data2.calendarId,
        eventId: data2.eventId,
      ));
    });
  });
  return DataSource(meetingCollection);
}

List getEventsInRange(var events, var date) {
  var lis = [];
  if(events==null) return lis;
  events.forEach((data) {
    int diffDays = date.difference(data.from).inDays;
    if (diffDays == 0 && data.from.day == date.day) {
      lis.add(data);
    } else if (date.difference(data.to).inDays == 0 &&
        data.to.day == date.day) {
      lis.add(data);
    } else if (date.isBefore(data.to) && date.isAfter(data.from)) {
      lis.add(data);
    }
  });
  return lis;
}