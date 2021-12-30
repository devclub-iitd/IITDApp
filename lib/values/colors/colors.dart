import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// App Colors Class - Resource class for storing app level color ants
class AppColors {
  //Default

  //User Search
  Color SEARCH_BG;
  Color Cancel_Button;
  Color FILTER;

  Color PRIMARY_COLOR;
  Color PRIMARY_COLOR_LIGHT;
  Color PRIMARY_COLOR_DARK;
  Color PRIMARY_TEXT_COLOR;
  Color ACCENT_TEXT_COLOR;
  Color ACCENT_COLOR;
  Color APP_BAR_START;
  Color APP_BAR_END;
  Color DEFAULT_WIDGET_BACKGROUND;
  Color DEFAULT_HIGHLIGHT_BACKGROUND;
  Color SCAFFOLD_BACKGROUND;
  //BottomNavBar
  Color BOTTOM_NAV_BACKGROUND;
  Color BOTTOM_NAV_SELECTED;
  Color BOTTOM_NAV_UNSELECTED;

  Color RAISED_BUTTON_BACKGROUND;
  Color RAISED_BUTTON_FOREGROUND;
  Color RAISED_BUTTON_FOREGROUND2;

  Color RAISED_BUTTON_ALT_BACKGROUND;
  Color RAISED_BUTTON_ALT_FOREGROUND;

  //Events
  Color TITLE_UNDERLINE;
  Color ALERT_DIALOG;
  Color ALERT_DIALOG_TEXT;

  //Login
  Color LOGIN_BACKGROUND;
  Color LOGIN_BUTTON_COLOR;
  Color SIGNUP_BUTTON_COLOR;

  //Attendance
  Color CARD_LIGHT;
  Color CARD_DARK;
  Color CALENDAR_BACKGROUND;
  Color COURSE_CARD;
  Color CALENDAR_BUTTON_COLOR;
  //   Color LinksSectionStart = Color.fromARGB(255, 255, 168, 0);
  //   Color LinksSectionEnd = Color.fromARGB(255, 255, 111, 0);
  //   Color LinksSectionEnd = Color.fromARGB(255,203, 53, 107);
  //   Color LinksSectionStart = Color.fromARGB(255, 192, 60, 90);
  Color LinksSectionEnd;
  Color LinksSectionStart;
  Color LinkSectionHeader;
  Color hintColor;
  Color canvasColor;
  Color cardColor;
  Color accentColor;

  //Map
  Color DEFAULT_LABEL_COLOR;
  Color TOGGLE_GRID_COLOR;
  Color TOGGLE_GRID_BUTTON_COLOR;
  Color TOGGLE_GRID_BUTTON_ICON_COLOR;
  Color TOGGLE_GRID_BUTTON_ICON_DISABLED_COLOR;
  Color MAP_BACKGROUND_COLOR;
  Color MAP_BLEND_COLOR;
  Color CURRENT_LOCATION_LABEL_COLOR;
  Color CURRENT_LOCATION_COLOR;
  Color FLOATING_BUTTON_BG;
  Color FLOATING_BUTTON_FG;
  Color FLOATING_BUTTON_SELECTED_BG;
  Color FLOATING_BUTTON_SELECTED_FG;
  Color SLIDE_UP_SHEET_COLOR;
  Color SLIDE_UP_SHEET_TEXT_COLOR;
  Color SLIDE_UP_SHEET_BUTTON_COLOR;

  AppColors() {
    //User Search
    SEARCH_BG = Color(0xffdddede);
    Cancel_Button = Color(0xff666666);
    FILTER = Color(0xff999999);

    //Default
    PRIMARY_COLOR = Color(0xFF35B4C5);
    PRIMARY_COLOR_LIGHT = Color(0xFFA5CFF1);
    PRIMARY_COLOR_DARK = Color(0xFF0D3656);
    PRIMARY_TEXT_COLOR = Colors.black;
    ACCENT_TEXT_COLOR = Colors.white;
    ACCENT_COLOR = Color(0xFFF2DA04);
    APP_BAR_START = Colors.indigo;
    APP_BAR_END = Colors.cyan;
    DEFAULT_WIDGET_BACKGROUND =
        // Color.fromRGBO(96, 125, 139, 0.1);
        Colors.white;
    DEFAULT_HIGHLIGHT_BACKGROUND = Color.fromRGBO(24, 255, 255, 0.1);
    SCAFFOLD_BACKGROUND =
        //  Color.fromRGBO(26, 35, 126, 0.6);
        // Color(0xFFECEFF1);
        Color(0xFFfefffe);
    //BottomNavBar
    BOTTOM_NAV_BACKGROUND = Color.fromRGBO(92, 107, 192, 1);
    BOTTOM_NAV_SELECTED = Color.fromRGBO(225, 225, 225, 1);
    BOTTOM_NAV_UNSELECTED = Color.fromRGBO(255, 255, 255, 0.6);

    RAISED_BUTTON_BACKGROUND = Color(0xFFA5CFF1);
    RAISED_BUTTON_FOREGROUND = Color(0xFF0D3656);

    RAISED_BUTTON_ALT_BACKGROUND = Color(0xFF7C8EEF);
    RAISED_BUTTON_ALT_FOREGROUND = Color(0xFFA5CFF1);

    //Events
    TITLE_UNDERLINE = Colors.blue;
    ALERT_DIALOG = Color.fromRGBO(57, 73, 171, 1);
    ALERT_DIALOG_TEXT = ACCENT_TEXT_COLOR;

    //Login
    LOGIN_BACKGROUND = Colors.indigo[600];
    LOGIN_BUTTON_COLOR = Colors.blueAccent;
    SIGNUP_BUTTON_COLOR = Colors.indigo[400];

    //Attendance
    CARD_LIGHT = APP_BAR_END;
    CARD_DARK = ACCENT_TEXT_COLOR;
    CALENDAR_BACKGROUND =
        // Color(0xFF1487B1);
        Color(0xFFEEEEEE);
    COURSE_CARD = DEFAULT_WIDGET_BACKGROUND;
    CALENDAR_BUTTON_COLOR = PRIMARY_TEXT_COLOR;
    //   LinksSectionStart = Color.fromARGB(255, 255, 168, 0);
    //   LinksSectionEnd = Color.fromARGB(255, 255, 111, 0);
    //   LinksSectionEnd = Color.fromARGB(255,203, 53, 107);
    //   LinksSectionStart = Color.fromARGB(255, 192, 60, 90);
    LinkSectionHeader = Colors.indigoAccent;
    LinksSectionEnd = Color.fromARGB(220, 86, 204, 242);
    LinksSectionStart = Color.fromARGB(220, 67, 166, 239);
    hintColor = Colors.white54;
    canvasColor = Colors.indigo[700]; //Colors.indigo[700];
    cardColor = Colors.indigo;
    accentColor = Colors.lightBlueAccent;

    //Map
    DEFAULT_LABEL_COLOR = Colors.black;
    TOGGLE_GRID_COLOR = Color.fromRGBO(63, 81, 181, 0.5);
    TOGGLE_GRID_BUTTON_COLOR = Color.fromRGBO(63, 81, 181, 0.8);
    TOGGLE_GRID_BUTTON_ICON_COLOR = Colors.white;
    TOGGLE_GRID_BUTTON_ICON_DISABLED_COLOR = Color.fromRGBO(63, 81, 181, 0.8);
    MAP_BACKGROUND_COLOR = Color.fromRGBO(40, 50, 40, 50);
    MAP_BLEND_COLOR = Color(0xFF80DEDA);
    CURRENT_LOCATION_LABEL_COLOR = Colors.indigo;
    CURRENT_LOCATION_COLOR = Colors.indigo;
    FLOATING_BUTTON_BG = Color.fromRGBO(63, 81, 181, 1);
    FLOATING_BUTTON_FG = Colors.white;
    FLOATING_BUTTON_SELECTED_BG = Colors.white;
    FLOATING_BUTTON_SELECTED_FG = Color.fromRGBO(63, 81, 181, 0.5);
    SLIDE_UP_SHEET_COLOR = Color(0xFFE1F5FE);
    SLIDE_UP_SHEET_TEXT_COLOR = Colors.black54;
    SLIDE_UP_SHEET_BUTTON_COLOR = Colors.cyan;
  }
  //Default
}

ThemeData lightTheme = ThemeData(
//            primarySwatch: Colors.indigo,
  hintColor: Colors.white54,
//            scaffoldBackgroundColor: Colors.indigo[900],
//            canvasColor: Colors.indigo[700],
  brightness: Brightness.light,
//            cardColor: Colors.indigo,
//            accentColor: Colors.lightBlueAccent
);
