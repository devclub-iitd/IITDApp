import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

var colorCollection = <Color>[
  Color(0xFFD20100),
  Color(0xFF0F8644),
  Color(0xFF8B1FA9),
  Color(0xFFFC571D),
  Color(0xFF85461E),
  Color(0xFFFF00FF),
  Color(0xFF3D4FB5),
  Color(0xFFE47C73),
  Color(0xFF636363),
];

var colorNames = <String>[
  'Red',
  'Green',
  'Purple',
  'Orange',
  'Caramel',
  'Magenta',
  'Blue',
  'Peach',
  'Gray',
];

var reminderUnits = <String>[
  'Minutes',
  'Hours',
  'Days',
  'Weeks',
];

var recurrenceOptions = <String>[
  'Does Not Repeat',
  'Daily',
  'Weekly',
  'Monthly',
  'Annually'
];

var viewOptions = {
  'Day': CalendarView.day,
  'Week': CalendarView.week,
  'Work Week': CalendarView.workWeek,
  'Agenda View': 0,
  'Month': CalendarView.month,
  'Timeline Day': CalendarView.timelineDay,
  'Timeline Week': CalendarView.timelineWeek,
  'Timeline WorkWeek': CalendarView.timelineWorkWeek
};
