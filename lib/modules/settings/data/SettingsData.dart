import 'package:IITDAPP/modules/settings/data/CommonFunctions.dart';
import 'package:IITDAPP/modules/settings/data/SettingsHandler.dart';
import 'package:IITDAPP/modules/settings/widgets/SettingsTextWidgets.dart';
import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

var commonKeys = [
  'defaultScreen',
  'theme',
  'showNotifications'
];

var defaultsForKey={commonKeys[0]: 'Dashboard',
'defaultCalendarView': 'AgendaView',
  'showOtherCalendars': true,
  'theme': 'System',
  'showNotifications': true
};

var indivScreenSettingsData = {
  'Dashboard': [],'Events': [],'Calendar': [
    SettingsModel(widgetType: SettingsDropdownTile(
        defaultValue: 'AgendaView',SPkey: 'defaultCalendarView',text: 'Set Default View',lis: {
      'Day': CalendarView.day,
      'Week': CalendarView.week,
      'Work Week': CalendarView.workWeek,
      'Agenda View': 0,
      'Month': CalendarView.month,
      'Timeline Day': CalendarView.timelineDay,
      'Timeline Week': CalendarView.timelineWeek,
      'Timeline WorkWeek': CalendarView.timelineWorkWeek})),
    SettingsModel(widgetType: SettingsSwitchTile(SPkey: 'showOtherCalendars',defaultValue: true,
        text: 'Show Other Device Calendars'))
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