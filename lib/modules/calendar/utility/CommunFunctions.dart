part of event_calendar;

DataSource filterEvents(var calendarModel, var exempted) {
  print('Entering filter events');
  var res = [];
  calendarModel.forEach((data) {
    if (exempted[data.name] == null || !exempted[data.name]) {
      res.add(data.events.data);
    }
  });
  print('Exiting filter events');
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
          attendee: data2.attendees,
          recurrence: data2.recurrenceRule,
          reminder: data2.reminders,
          location: data2.location));
    });
  });
  return DataSource(meetingCollection);
}

List getEventsInRange(var events, var date) {
  var lis = [];
  if (events == null) return lis;
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

String getRecurrenceString(RecurrenceRule rRule) {
  if (rRule == null) {
    return recurrenceOptions[0];
  }
  var res = '';
  switch (rRule.recurrenceFrequency) {
    case RecurrenceFrequency.Daily:
      res = recurrenceOptions[1];
      break;
    case RecurrenceFrequency.Weekly:
      res = recurrenceOptions[2];
      break;
    case RecurrenceFrequency.Monthly:
      res = recurrenceOptions[2];
      break;
    case RecurrenceFrequency.Yearly:
      res = recurrenceOptions[3];
      break;
  }
  return res;
}

String getAttendeeString(List<Attendee> lis) {
  var res = '';
  if (lis == null) {
    return res;
  }
  lis.forEach((element) {
    res += element.name + '\n';
  });
  return res;
}

String getReminderString(List<Reminder> rem) {
  var res = 0;
  if (rem == null || rem.isEmpty) {
    return '';
  }
  res = rem[0].minutes;
  if (res % (60 * 24 * 7) == 0) {
    return (res / (60 * 24 * 7)).toString() + ' Weeks';
  }
  if (res % (60 * 24) == 0) {
    return (res / (60 * 24)).toString() + ' Days';
  }
  if (res % (60) == 0) {
    return (res / (60)).toString() + ' Hours';
  }
  return (res).toString() + ' Minutes';
}

// ignore: always_declare_return_types
makeEventElementsNonNull(Event ev) {
  ev.description ??= '';
  ev.startTimeZone ??= '';
  ev.endTimeZone ??= '';
  ev.location ??= '';
//  if(ev.url==''||ev.url==null) {
//    ev.url ??= Uri('');
//  }
}
