import 'package:flutter/material.dart';

import 'colors.dart';

class DarkAppColors extends AppColors {
  DarkAppColors() {
    //User Search
    SEARCH_BG = Color(0xff2f2f2f);
    Cancel_Button = Color(0xffcccccd);
    FILTER = Color(0xffdddddd);
    //Default
    APP_BAR_START = Color(0xFF263238);
    APP_BAR_END = Color(0xFF455A64);
    PRIMARY_TEXT_COLOR = Colors.white;
    SCAFFOLD_BACKGROUND = Color(0xFF212121);
    DEFAULT_WIDGET_BACKGROUND = Color.fromRGBO(50, 50, 50, 0.8);
    RAISED_BUTTON_BACKGROUND = Colors.blue;//Colors.tealAccent
    RAISED_BUTTON_FOREGROUND = Colors.lightBlue[100];//PRIMARY_COLOR_DARK

    RAISED_BUTTON_ALT_BACKGROUND = Colors.teal;
    RAISED_BUTTON_ALT_FOREGROUND = PRIMARY_COLOR_DARK;

    //BottomNavBar
    BOTTOM_NAV_BACKGROUND = Color(0xFF263238);
    BOTTOM_NAV_SELECTED = Colors.white54;
    BOTTOM_NAV_UNSELECTED = Colors.white30;

    //Login
    LOGIN_BACKGROUND = Colors.blueGrey[800];
    LOGIN_BUTTON_COLOR = Colors.tealAccent[400];
    SIGNUP_BUTTON_COLOR = Colors.teal[400];

    //Attendance
    COURSE_CARD = DEFAULT_WIDGET_BACKGROUND;
    CALENDAR_BACKGROUND = DEFAULT_WIDGET_BACKGROUND;
    CARD_LIGHT = Colors.greenAccent[700].withOpacity(0.6);
    CARD_DARK = Colors.black54;

    //Events
    TITLE_UNDERLINE = Colors.teal;
    ALERT_DIALOG = Color(0xFF303030);
    ALERT_DIALOG_TEXT = ACCENT_TEXT_COLOR;

    //Links
    LinkSectionHeader = Colors.teal;
    LinksSectionEnd = APP_BAR_START;
    LinksSectionStart = APP_BAR_END;

    //Map
    FLOATING_BUTTON_BG = Colors.black;
    FLOATING_BUTTON_FG = Colors.tealAccent;
    FLOATING_BUTTON_SELECTED_BG = Colors.tealAccent;
    FLOATING_BUTTON_SELECTED_FG = Colors.black;
    SLIDE_UP_SHEET_COLOR = Color(0xFF303030);
    SLIDE_UP_SHEET_TEXT_COLOR = Colors.white54;
    SLIDE_UP_SHEET_BUTTON_COLOR = Colors.tealAccent;
    TOGGLE_GRID_COLOR = Colors.black38;
    TOGGLE_GRID_BUTTON_COLOR = Colors.black54;
    TOGGLE_GRID_BUTTON_ICON_COLOR = Colors.white;
    TOGGLE_GRID_BUTTON_ICON_DISABLED_COLOR = Colors.black87;
  }
  //Default
}

ThemeData darkTheme = ThemeData(
//            primarySwatch: Colors.indigo,
  hintColor: Colors.white54,
  highlightColor: Colors.white54,
//            scaffoldBackgroundColor: Colors.indigo[900],
//            canvasColor: Colors.indigo[700],
  brightness: Brightness.dark,
//            cardColor: Colors.indigo,
//            accentColor: Colors.lightBlueAccent
);
