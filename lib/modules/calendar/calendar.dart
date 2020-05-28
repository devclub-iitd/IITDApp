library event_calendar;

import 'dart:convert';
import 'dart:math';
import 'package:IITDAPP/modules/calendar/data/CalendarModel.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:IITDAPP/modules/calendar/data/Constants.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

part './screens/AppointmentEditor.dart';
part './data/MeetingClass.dart';
part './widgets/color-picker.dart';
part './utility/CalendarHandler.dart';
part './utility/CommunFunctions.dart';
part './widgets/CustomSwiper.dart';
part './widgets/CustomModal.dart';

List<Color> _colorCollection;
List<String> _colorNames;
int _selectedColorIndex = 0;
// ignore: unused_element
int _selectedTimeZoneIndex = 0;
List<String> _timeZoneCollection;
DataSource _events;
Meeting _selectedAppointment;
DateTime _startDate;
TimeOfDay _startTime;
DateTime _endDate;
TimeOfDay _endTime;
bool _isAllDay;
String _subject = '';
String _notes = '';
String _reminder = '';
String _recurrence = 'Does Not Repeat';
String _location = '';
String _attendee = '';
List<String> eventNameCollection;
// ignore: non_constant_identifier_names
String IITDCalendarId = '';
String starredCalendarId = '';
String userEventsCalendarId = '';



class CalendarScreen extends StatefulWidget {

  static const String routeName = '/calendar';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DeviceCalendarPlugin _deviceCalendarPlugin;
  List<CalendarModel> calendarModel = [];
  List<Calendar> _calendars;
  List<Calendar> get _writableCalendars =>
      _calendars?.where((c) => !c.isReadOnly)?.toList() ?? <Calendar>[];

//  List<Calendar> get _readOnlyCalendars =>
//      _calendars?.where((c) => c.isReadOnly)?.toList() ?? <Calendar>[];

  _CalendarScreenState() {
    _deviceCalendarPlugin = DeviceCalendarPlugin();
  }

  var viewType;
  List<Meeting> appointments;
  bool showAgenda;
  var lastSelectedDate;
  var exempted;
  bool showPopUp;
  List<Appointment> agendaAppointments;

  CalendarController _calendarController;

  void loadLicences() async {
  }

  // ignore: always_declare_return_types
  changeViewType(var view) {
    setState(() {
      if (view == 0) {
        viewType = CalendarView.month;
        showAgenda = true;
      } else {
        viewType = view;
        showAgenda = false;
      }
      print('odasjl');
    });
  }

  void changeExempted(var res) {
    setState(() {
      exempted = res;
    });
  }

  @override
  void initState() {
    // loadLicences();
    agendaAppointments = <Appointment>[];
    showPopUp = false;
    exempted = {};
    showAgenda = true;
    viewType = CalendarView.month;
    appointments = null;//getMeetingDetails();
    _calendarController = CalendarController();
    _calendarController.addPropertyChangedListener((String prop) {
      print('hi');
      print(prop);
    });
    _calendarController.selectedDate = DateTime.now();
    lastSelectedDate = _calendarController.displayDate;
    _events = DataSource(appointments);
    _selectedAppointment = null;
    _selectedColorIndex = 0;
    _selectedTimeZoneIndex = 0;
    _subject = '';
    _notes = '';
    super.initState();
    _retrieveCalendars();
  }

  void _retrieveCalendars() async {
    try {
      var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess && !permissionsGranted.data) {
        permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
          return;
        }
      }

      print('Calendars will be retrieved now');

      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
      setState(() {
        _calendars = calendarsResult?.data;
        _writableCalendars.asMap().forEach((idx,data) {
          Future _retrieveCalendarEvents(bool last) async {
            final startDate = DateTime.now().add(Duration(days: -365));
            final endDate = DateTime.now().add(Duration(days: 365));
            var calendarEventsResult =
            await _deviceCalendarPlugin.retrieveEvents(
                data.id,
                RetrieveEventsParams(
                    startDate: startDate, endDate: endDate));
            calendarModel.add(CalendarModel(
                id: data.id,
                name: data.name,
                accountName: data.accountName,
                color: data.color,
                events: calendarEventsResult));
            if(last){
              checkForCalIds(calendarModel);
              print('Events shud be displayed now');
              _events = filterEvents(calendarModel,exempted);
            }
          }

          _retrieveCalendarEvents(idx==_writableCalendars.length-1);
        });
        print('hello');
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
      if(showPopUp){
        setState(() {
          showPopUp = false;
        });
        return;
      }
//
//      if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
//        setState(() {
//          agendaAppointments = calendarTapDetails.appointments;
//        });
//      }

      if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
          calendarTapDetails.targetElement != CalendarElement.appointment) {
        return;
      }

      if (viewType == CalendarView.month &&
          (calendarTapDetails.appointments.isEmpty || showAgenda)) {
        if (_calendarController.selectedDate != lastSelectedDate) {
          lastSelectedDate = _calendarController.selectedDate;
          return;
        }
      }

      if(viewType == CalendarView.month && !showAgenda && calendarTapDetails.appointments.isNotEmpty){
        setState(() {
          showPopUp = true;
          lastSelectedDate = _calendarController.selectedDate;
        });
        return;
      }

      setState(() {
        lastSelectedDate = _calendarController.selectedDate;
        _selectedAppointment = null;
        _isAllDay = false;
        _selectedColorIndex = 0;
        _selectedTimeZoneIndex = 0;
        _subject = '';
        _notes = '';
        if (viewType == CalendarView.month) {
          viewType = CalendarView.day;
        } else {
          if (calendarTapDetails.appointments != null &&
              calendarTapDetails.appointments.length == 1) {
            final Meeting meetingDetails = calendarTapDetails.appointments[0];
            _startDate = meetingDetails.from;
            _endDate = meetingDetails.to;
            _isAllDay = meetingDetails.isAllDay;
            _selectedColorIndex =
                _colorCollection.indexOf(meetingDetails.background);
            _selectedTimeZoneIndex = meetingDetails.startTimeZone == ''
                ? 0
                : _timeZoneCollection.indexOf(meetingDetails.startTimeZone);
            _subject = meetingDetails.eventName == '(No title)'
                ? ''
                : meetingDetails.eventName;
            _notes = meetingDetails.description;
            _selectedAppointment = meetingDetails;
          } else {
            // ignore: omit_local_variable_types
            final DateTime date = calendarTapDetails.date;
            _startDate = date;
            _endDate = date.add(const Duration(hours: 1));
          }
          _startTime =
              TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
          _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
          Navigator.push<Widget>(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => AppointmentEditor()),
          );
        }
      });
    }

    void openEditorDirectly() {
//      getEventsInRange(_events, _calendarController.selectedDate, 3);
      // ignore: omit_local_variable_types
      final DateTime date =
          _calendarController.selectedDate ?? _calendarController.displayDate;
      _startDate = date;
      _endDate = date.add(const Duration(hours: 1));
      _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
      _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
      _selectedAppointment = null;
      _isAllDay = false;
      _selectedColorIndex = 0;
      _selectedTimeZoneIndex = 0;
      _subject = '';
      _notes = '';
      Navigator.push<Widget>(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => AppointmentEditor()),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: Text('Calendar'),
      ),
      drawer: AppDrawer(tag: 'Calendar'),
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 31),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: () async {
                  openEditorDirectly();
                },
                child: Icon(Icons.add),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                showBarModalBottomSheet(
                  expand: false,
                  context: context,
                  builder: (context, scrollController) => CustomModal(
                      changeViewType,
                      viewType,
                      showAgenda,
                      calendarModel,
                      changeExempted),
                );
              },
              child: Icon(Icons.graphic_eq),
            ),
          ),
        ],
      ),
      body: Stack(children: [
        Opacity(
          opacity: showPopUp?0.2:1,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: SfCalendar(
                  initialSelectedDate: _calendarController.displayDate,
                  controller: _calendarController,
                  headerHeight: 50,
                  headerStyle: CalendarHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                          fontSize: 24, color: Colors.black, letterSpacing: 2)),
                  view: viewType,
                  onViewChanged: (ViewChangedDetails details) {
                    lastSelectedDate = _calendarController.selectedDate;
                  },
                  onTap: onCalendarTapped,
                  firstDayOfWeek: 1,
                  dataSource: _events, //DataSource(getMeetingDetails()),
                  monthViewSettings: MonthViewSettings(
                    showAgenda: showAgenda,
                    appointmentDisplayMode: showAgenda?MonthAppointmentDisplayMode.indicator:MonthAppointmentDisplayMode.appointment,
                    dayFormat: 'EEE',
                    monthCellStyle: MonthCellStyle(
                      textStyle: TextStyle(fontSize: 16, color: Colors.black),
                      todayTextStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  selectionDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    shape: BoxShape.rectangle,
                  ),
                  todayHighlightColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        !showPopUp?Container():Center(
          child: Container(
            color: Colors.transparent,
            height: 500,
            child: Center(
                child: CustomSwiper(_calendarController.selectedDate, _events)),
          ),
        ),
      ]),
    );
  }
}
