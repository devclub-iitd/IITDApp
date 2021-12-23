part of event_calendar;

final List<String> keys = ['AcadCalendar', 'EventsCalendar', 'UsersCalendar'];

final List<String> calNames = [
  'Academic Calendar',
  'IITD Connect',
  'User Events'
];

const String accountName = 'IITDAPP';

void checkForCalIds(var calendarModel) {
  calendarModel.forEach((data) => {
        if (data.name == calNames[0])
          processCalIds(data, 0)
        else if (data.name == calNames[1])
          processCalIds(data, 1)
        else if (data.name == calNames[2])
          processCalIds(data, 2)
      });
  if (IITDCalendarId == '') {
    createCalendar(calNames[0], accountName);
  }
  if (starredCalendarId == '') {
    createCalendar(calNames[1], accountName);
  }
  if (userEventsCalendarId == '') {
    createCalendar(calNames[2], accountName);
  }
}

void processCalIds(var data, int idx) {
  switch (idx) {
    case 0:
      IITDCalendarId = data.id;
      break;
    case 1:
      starredCalendarId = data.id;
      break;
    case 2:
      userEventsCalendarId = data.id;
  }
}

void createCalendar(var name, var account) async {
  var result = await DeviceCalendarPlugin().createCalendar(
    name,
    calendarColor: Colors.red,
    localAccountName: account,
  );
  print(result);
}
