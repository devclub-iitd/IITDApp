import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// App Colors Class - Resource class for storing app level color constants
class AppColors {
  static const Color PRIMARY_COLOR = Color(0xFF35B4C5);
  static const Color PRIMARY_COLOR_LIGHT = Color(0xFFA5CFF1);
  static const Color PRIMARY_COLOR_DARK = Color(0xFF0D3656);
  static const Color ACCENT_COLOR = Color(0xFFF2DA04);
  static const Color APP_BAR_START = Colors.indigo;
  static const Color APP_BAR_END = Colors.cyan;

  //Attendance
  static const Color CARD_LIGHT = Colors.cyan;
  static const Color CARD_DARK = Color(0xFF1A237E);
  static const Color CARD_SUB_DARK = Colors.black54;
  static const Color CARD_SUB_LIGHT = Colors.white30;
  static const Color ATTENDANCE_HEADING_LIGHT = Colors.white70;
  static const Color ATTENDANCE_HEADING_DARK = Colors.white30;
  static const Color CALENDAR_BACKGROUND = Color(0xFF1487B1);
  static const Color COURSE_CARD = Color.fromRGBO(90, 0, 150, 100);
  static const Color CALENDAR_BUTTON_COLOR = Color(0xFF1A237E);
//  static const Color LinksSectionStart = Color.fromARGB(255, 255, 168, 0);
//  static const Color LinksSectionEnd = Color.fromARGB(255, 255, 111, 0);
//  static const Color LinksSectionEnd = Color.fromARGB(255,203, 53, 107);
//  static const Color LinksSectionStart = Color.fromARGB(255, 192, 60, 90);
  static const Color LinksSectionEnd = Color.fromARGB(220, 86, 204, 242);
  static const Color LinksSectionStart = Color.fromARGB(220, 67, 166, 239);
  static const Color hintColor = Colors.white54;
  static Color canvasColor = Colors.indigo[700]; //Colors.indigo[700];
  static const Color cardColor = Colors.indigo;
  static const Color accentColor = Colors.lightBlueAccent;

  //Map
  static const Color DEFAULT_LABEL_COLOR = Colors.black;
  static const Color TOGGLE_GRID_COLOR = Color.fromRGBO(63, 81, 181, 0.5);
  static const Color TOGGLE_GRID_BUTTON_COLOR =
      Color.fromRGBO(63, 81, 181, 0.8);
  static const Color TOGGLE_GRID_BUTTON_ICON_COLOR = Colors.white;
  static const Color TOGGLE_GRID_BUTTON_ICON_DISABLED_COLOR =
      Color.fromRGBO(63, 81, 181, 0.8);
  static const Color MAP_BACKGROUND_COLOR = Color.fromRGBO(40, 50, 40, 50);
  static const Color CURRENT_LOCATION_LABEL_COLOR = Colors.indigo;
  static const Color CURRENT_LOCATION_COLOR = Colors.indigo;
  static const Color FLOATING_BUTTON_BG = Colors.black;
  static const Color FLOATING_BUTTON_FG = Colors.cyanAccent;
  static const Color FLOATING_BUTTON_SELECTED_BG = Colors.cyanAccent;
  static const Color FLOATING_BUTTON_SELECTED_FG = Colors.black;
  static const Color SLIDE_UP_SHEET_COLOR = Colors.black;
  static const Color SLIDE_UP_SHEET_TEXT_COLOR = Colors.white54;
  static const Color SLIDE_UP_SHEET_BUTTON_COLOR = Colors.cyanAccent;

  //News
  static const RAISED_BUTTON_TEXT_COLOR = Color(0xFF0d47A1);
  static const RAISED_BUTTON_COLOR = Colors.lightBlue;
  static const SECTION_HEADING_COLOR = Colors.white70;
}

ThemeData darkTheme = ThemeData(
//            primarySwatch: Colors.indigo,
  hintColor: Colors.white54,
//            scaffoldBackgroundColor: Colors.indigo[900],
//            canvasColor: Colors.indigo[700],
  brightness: Brightness.dark,
//            cardColor: Colors.indigo,
//            accentColor: Colors.lightBlueAccent
);
ThemeData lightTheme = ThemeData(
//            primarySwatch: Colors.indigo,
  hintColor: Colors.white54,
//            scaffoldBackgroundColor: Colors.indigo[900],
//            canvasColor: Colors.indigo[700],
  brightness: Brightness.light,
//            cardColor: Colors.indigo,
//            accentColor: Colors.lightBlueAccent
);
