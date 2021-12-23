// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';

class AttendanceCalendar extends StatelessWidget {
  // Text Styles
  static const PRESENT_DAY_TEXT_STYLE = TextStyle(
      color: Color(0xFF12EAD4), fontSize: 15, fontWeight: FontWeight.w900);
  static const DAY_TEXT_STYLE = TextStyle(
      color: Color(0xFFA1A1A1), fontSize: 15, fontWeight: FontWeight.w300);
  static const DAY_NAME_TEXT_STYLE =
      TextStyle(color: Color(0x701A1A1A), fontSize: 18);

  final List<DateTime> presentDates;
  const AttendanceCalendar(this.presentDates);

  @override
  Widget build(BuildContext context) {
    var _markedDates = EventList<Event>(
      events: {},
    );
    for (var i = 0; i < presentDates.length; i++) {
      _markedDates.add(
          presentDates[i],
          Event(
              date: presentDates[i],
              icon: _presentIcon(day: presentDates[i].day.toString())));
    }
    var HEADER_TEXT_STYLE = TextStyle(
        color: Provider.of<ThemeModel>(context)
            .theme
            .PRIMARY_TEXT_COLOR
            .withOpacity(0.3),
        fontSize: 20);
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Provider.of<ThemeModel>(context).theme.CALENDAR_BACKGROUND,
      ),
      child: CalendarCarousel<Event>(
        weekendTextStyle: DAY_TEXT_STYLE,
        weekdayTextStyle: DAY_NAME_TEXT_STYLE.copyWith(color: Colors.white70),
        daysTextStyle: DAY_TEXT_STYLE,
        headerTextStyle: HEADER_TEXT_STYLE,
        iconColor: Colors.white60,
        todayButtonColor: Colors.transparent,
        markedDatesMap: _markedDates,
        markedDateShowIcon: true,
        markedDateIconMaxShown: 1,
        markedDateIconBuilder: (event) => event.icon,
        markedDateMoreShowTotal: null,
        showOnlyCurrentMonthDate: true,
        todayTextStyle: DAY_TEXT_STYLE,
        childAspectRatio: 1.5,
        height: 0.5 * MediaQuery.of(context).size.height,
      ),
    );
  }
}

class _presentIcon extends StatelessWidget {
  const _presentIcon({
    Key key,
    @required this.day,
  }) : super(key: key);

  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Provider.of<ThemeModel>(context).theme.CALENDAR_BACKGROUND,
      child: Center(
        child: Text(day, style: AttendanceCalendar.PRESENT_DAY_TEXT_STYLE),
      ),
    );
  }
}
