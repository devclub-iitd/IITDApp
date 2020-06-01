part of event_calendar;

List<Meeting> getMeetingDetails() {
  // ignore: omit_local_variable_types
  final List<Meeting> meetingCollection = <Meeting>[];
  eventNameCollection = <String>[];
  eventNameCollection.add('General Meeting');
  eventNameCollection.add('Plan Execution');
  eventNameCollection.add('Project Plan');
  eventNameCollection.add('Consulting');
  eventNameCollection.add('Support');
  eventNameCollection.add('Development Meeting');
  eventNameCollection.add('Scrum');
  eventNameCollection.add('Project Completion');
  eventNameCollection.add('Release updates');
  eventNameCollection.add('Performance Check');

  _colorCollection = <Color>[];
  _colorCollection.add(const Color(0xFF0F8644));
  _colorCollection.add(const Color(0xFF8B1FA9));
  _colorCollection.add(const Color(0xFFD20100));
  _colorCollection.add(const Color(0xFFFC571D));
  _colorCollection.add(const Color(0xFF85461E));
  _colorCollection.add(const Color(0xFFFF00FF));
  _colorCollection.add(const Color(0xFF3D4FB5));
  _colorCollection.add(const Color(0xFFE47C73));
  _colorCollection.add(const Color(0xFF636363));

  _colorNames = <String>[];
  _colorNames.add('Green');
  _colorNames.add('Purple');
  _colorNames.add('Red');
  _colorNames.add('Orange');
  _colorNames.add('Caramel');
  _colorNames.add('Magenta');
  _colorNames.add('Blue');
  _colorNames.add('Peach');
  _colorNames.add('Gray');

  _timeZoneCollection = <String>[];
  _timeZoneCollection.add('Default Time');
  var today = DateTime.now();
  var random = Random();
  for (var month = -1; month < 2; month++) {
    for (var day = -5; day < 5; day++) {
      for (var hour = 9; hour < 18; hour += 5) {
        meetingCollection.add(Meeting(
          from: today
              .add(Duration(days: (month * 30) + day))
              .add(Duration(hours: hour)),
          to: today
              .add(Duration(days: (month * 30) + day))
              .add(Duration(hours: hour + 2)),
          background: _colorCollection[random.nextInt(9)],
          startTimeZone: '',
          endTimeZone: '',
          description: '',
          isAllDay: false,
          eventName: eventNameCollection[random.nextInt(7)],
        ));
      }
    }
  }

  return meetingCollection;
}

class DataSource extends CalendarDataSource {
  DataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  bool isAllDay(int index) => appointments[index].isAllDay;

  @override
  String getSubject(int index) => appointments[index].eventName;

  @override
  String getStartTimeZone(int index) => appointments[index].startTimeZone;

  @override
  String getNotes(int index) => appointments[index].description;

  @override
  String getEndTimeZone(int index) => appointments[index].endTimeZone;

  @override
  Color getColor(int index) => appointments[index].background;

  @override
  DateTime getStartTime(int index) => appointments[index].from;

  @override
  DateTime getEndTime(int index) => appointments[index].to;
}

class Meeting {
  Meeting(
      {@required this.from,
        @required this.to,
        this.background = Colors.green,
        this.isAllDay = false,
        this.eventName = '',
        this.startTimeZone = '',
        this.endTimeZone = '',
        this.calendarId = '',
        this.description = '',
        this.location,
        this.recurrence,
        this.attendee,
        this.reminder,
        this.eventId});

  final String eventId;
  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
  final String startTimeZone;
  final String endTimeZone;
  final String description;
  final String calendarId;
  final String location;
  final List<Attendee> attendee;
  final RecurrenceRule recurrence;
  final List<Reminder> reminder;
}
