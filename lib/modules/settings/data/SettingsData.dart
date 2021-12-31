// import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/settings/widgets/SettingsTextWidgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

var commonKeys = [
  'defaultScreen',
  'theme',
  'showEventNotifications',
  'avatar',
  'showNewsNotifications',
  'bgimage',
];

var defaultsForKey = {
  commonKeys[0]: 'Dashboard',
  'defaultCalendarView': 'Agenda View',
  'showOtherCalendars': true,
  'theme': 'System',
  'avatar': 'mikasa',
  'bgimage': 'OwO',
  'showEventNotifications': true,
  'showNewsNotifications': true,
  'newsItemPerPage': '5',
  'MapMarkerSize': 15.0,
  'MapLabelSize': 20.0,
  'MinimumAttendance': 75.0
};

var indivScreenSettingsData = {
  'Dashboard': [],
  'Events': [],
  'Calendar': [
    SettingsModel(
        widgetType: SettingsDropdownTile(
            defaultValue: 'AgendaView',
            SPkey: 'defaultCalendarView',
            text: 'Set Default View',
            lis: {
          'Day': CalendarView.day,
          'Week': CalendarView.week,
          'Work Week': CalendarView.workWeek,
          'Agenda View': 0,
          'Month': CalendarView.month,
          'Timeline Day': CalendarView.timelineDay,
          'Timeline Week': CalendarView.timelineWeek,
          'Timeline WorkWeek': CalendarView.timelineWorkWeek
        })),
    SettingsModel(
        widgetType: SettingsSwitchTile(
            SPkey: 'showOtherCalendars',
            defaultValue: true,
            text: 'Show Other Device Calendars'))
  ],
  'News': [
    // SettingsModel(
    //     widgetType: SettingsDropdownTile(
    //   text: 'News Items Per Page',
    //   defaultValue: '5',
    //   SPkey: 'newsItemsPerPage',
    //   lis: {'5': 5, '10': 10, '20': 20},
    // )),
    // SettingsModel(
    //     widgetType: SettingsAlertDialogButton(
    //         onTap: NewsHistoryProvider.clearHistory,
    //         text: 'Clear History',
    //         alertTitle: 'Clear complete news History?',
    //         alertDesc: 'This will erase all news history from device',
    //         showArrow: false))
  ],
  'Attendance': [
    SettingsModel(
        widgetType: SettingsSliderRow(
      defaultValue: defaultsForKey['MinimumAttendance'],
      SPkey: 'MinimumAttendance',
      title: 'Minimum Attendance',
      max: 90.0,
      min: 30.0,
      getTexValue: (value) {
        return '${value.round()}%';
      },
    )),
  ],
  'Map': [
    // SettingsModel(
    //     widgetType: SettingsSliderRow(
    //   defaultValue: defaultsForKey['MapLabelSize'],
    //   SPkey: 'MapLabelSize',
    //   title: 'LabelSize',
    //   max: 30.0,
    //   min: 10.0,
    //   divisions: 10,
    //   trailing: Icon(Icons.location_on),
    // )),
    // SettingsModel(
    //     widgetType: SettingsSliderRow(
    //   defaultValue: defaultsForKey['MapMarkerSize'],
    //   SPkey: 'MapMarkerSize',
    //   title: 'MarkerSize',
    //   max: 20.0,
    //   min: 10.0,
    //   divisions: 10,
    //   trailing: Icon(Icons.location_on),
    // )),
  ]
};

class SettingsModel {
  bool heading;
  String key;
  var defaultValue;
  var widgetType;
  var params;
  SettingsModel(
      {this.heading = false,
      this.key,
      this.defaultValue,
      this.widgetType,
      this.params});
}
//SettingsModel(key: commonKeys[0],defaultValue: 'User Dashboard',widgetType: SettingsTextButton,
//params: {'title': 'Set User Dashboard as default','subtitle': generateDefaultScreenSubtitle(),'onTap': changeDefaultScreen('User Dashboard')})
