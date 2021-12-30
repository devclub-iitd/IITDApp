import 'dart:convert';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

Map<String, DayOfWeek> textToDayOfWeek = {
  'Mo': DayOfWeek.Monday,
  'Tu': DayOfWeek.Tuesday,
  'We': DayOfWeek.Wednesday,
  'Th': DayOfWeek.Thursday,
  'Fr': DayOfWeek.Friday,
  'Sa': DayOfWeek.Saturday,
  'Su': DayOfWeek.Sunday,
};

var textToDayofWeekInt = {
  'Mo': 1,
  'Tu': 2,
  'We': 3,
  'Th': 4,
  'Fr': 5,
  'Sa': 6,
  'Su': 7,
};

var intToTextDay = {
  1: 'Mo',
  2: 'Tu',
  3: 'We',
  4: 'Th',
  5: 'Fr',
  6: 'Sa',
  7: 'Su',
};

Future<String> getJson(fn) async {
  return rootBundle.loadString(fn);
}

createCalForSlot(
    holidays, times, DeviceCalendarPlugin dc, course_name, cal_id) async {
  for (var time in times) {
    List<DayOfWeek> daysOfWeek = [];
    for (var day in time[0]) {
      daysOfWeek.add(textToDayOfWeek[day]);
    }
    var endDate = DateFormat("dd/MM/yyyy").parse(holidays['endingDate']);
    var rrule = RecurrenceRule(RecurrenceFrequency.Weekly,
        interval: 1, endDate: endDate, daysOfWeek: daysOfWeek);

    // Define the start date as the date with first occurence of day occurs starting from now
    var startDate = DateTime.now();
    var startDateTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      int.parse(time[1][0].split(':')[0]),
      int.parse(time[1][0].split(':')[1]),
    ); // Extract Day from startDateTime
    for (int i = 0; i < 7; i++) {
      if (time[0].contains(intToTextDay[startDateTime.weekday])) {
        break;
      }
      startDateTime = startDateTime.add(Duration(days: 1));
    }
    var endDateTime = DateTime(
      startDateTime.year,
      startDateTime.month,
      startDateTime.day,
      int.parse(time[1][1].split(':')[0]),
      int.parse(time[1][1].split(':')[1]),
    );

    var event = Event(cal_id, // Google Calendar ID
        title: course_name, // Course Name
        description: '2', // Course Name
        start: startDateTime,
        end: endDateTime,
        recurrenceRule: rrule);

    String exdate = "";
    // Construct the exdate from the holidays
    for (var holiday in holidays['excludedDates']) {
      var date = DateFormat("dd/MM/yyyy")
          .parse(holiday); //DateFormat("yyyyMMddThhmmssZ").parse(holiday);
      date = date.add(
          Duration(hours: startDateTime.hour, minutes: startDateTime.minute));
      exdate += date
              .toUtc()
              .toIso8601String()
              .replaceAll('-', '')
              .replaceAll(':', '')
              .replaceAll('.000', '') +
          ",";
    }
    event.exdate = exdate.substring(0, exdate.length - 1);

    var createEventResult = await dc.createOrUpdateEvent(event);
    if (!createEventResult.isSuccess) return false;
    var eventId = createEventResult.data;

    for (var extra in holidays['extraDays']) {
      var date = DateFormat("dd/MM/yyyy")
          .parse(extra[0]); //DateFormat("yyyyMMddThhmmssZ").parse(holiday);
      if (time[0].contains(extra[1])) {
        var startDate = date.add(
            Duration(hours: startDateTime.hour, minutes: startDateTime.minute));
        var endDate = date.add(
            Duration(hours: endDateTime.hour, minutes: endDateTime.minute));
        var event = Event(
          cal_id, // Google Calendar ID
          title: course_name, // Course Name
          description: '2', // Course Name
          start: startDate,
          end: endDate,
        );
        dc.createOrUpdateEvent(event);
      }
    }

    // Now add the extra working days
  }
  print('Done Exporting');
}

generate_calendar_(Map<String, String> courses) async {
  // Given Courses Map, iterate over the map and create new recurrence event for each course
  // This will be followed by removing the holiday dates
  // This will be followed by adding the extra timetable days
  // We are all set.
  DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  var slotting =
      json.decode(await getJson('assets/courses/slotting_pattern.jsonc'));
  var holidays = json.decode(await getJson('assets/courses/holidays.jsonc'));

  for (var course in courses.keys) {
    var slot = courses[course];
    // Check if slot is in the slotting dict
    if (slotting.containsKey(slot)) {
      // If it is, then add the course to the slotting dict
      createCalForSlot(
          holidays, slotting[slot], _deviceCalendarPlugin, course, '2');
    } else {
      continue;
    }
  }
}
