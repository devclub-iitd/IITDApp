import 'package:IITDAPP/modules/calendar/calendar.dart';
import 'package:device_calendar/device_calendar.dart';

// ignore: always_declare_return_types
updateCalendar() async {
  var _deviceCalendarPlugin = DeviceCalendarPlugin();

  var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
  if (permissionsGranted.isSuccess && !permissionsGranted.data) {
    permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
    if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
      return;
    }
  }

  await QueueManager.executeList(await QueueManager.getList());
  final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();

  var _calendars = calendarsResult?.data;
  _calendars.asMap().forEach((idx, data) {
    Future _retrieveCalendarEvents() async {
      final startDate = DateTime.now().add(Duration(days: -180));
      final endDate = DateTime.now().add(Duration(days: 180));
      if (data.name == 'IITD Connect') {
        var calendarEventsResult = await _deviceCalendarPlugin.retrieveEvents(
            data.id,
            RetrieveEventsParams(startDate: startDate, endDate: endDate));
        getAllEvents(calendarEventsResult, 0, startDate, endDate);
      }
      starredCalendarId = data.id;
    }

    _retrieveCalendarEvents();
  });
}
