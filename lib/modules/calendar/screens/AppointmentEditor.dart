part of event_calendar;

class AppointmentEditor extends StatefulWidget {
  @override
  AppointmentEditorState createState() => AppointmentEditorState();
}

class AppointmentEditorState extends State<AppointmentEditor> {
  var reminder;
  var recurrence;
  bool permissionGranted;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    permissionGranted = true;
    // var initializationSettingsAndroid =
    //     AndroidInitializationSettings('@mipmap/ic_launcher');
    // var initializationSettingsIOS = IOSInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    // );
    // var initializationSettings = InitializationSettings(
    //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: onSelectNotification);
    // requestPermission();
  }

  Future requestPermission() async {
    // TODO: Fix this
    // var result = await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         IOSFlutterLocalNotificationsPlugin>()
    //     ?.requestPermissions(
    //       alert: true,
    //       badge: true,
    //       sound: true,
    //     );
    var result = true;

    setState(() {
      permissionGranted = result;
    });
  }

  String generatePayload(Event ev) {
    var res = '';
    res += ev.title +
        '%&' +
        ev.description +
        '%&' +
        DateFormat('yyyy-MM-dd  HH:mm:ss').format(ev.start) +
        ' - ' +
        DateFormat('HH:mm:ss').format(ev.end);
    return res;
  }

  Future onSelectNotification(String payload) async {
    var firstIdx = payload.indexOf('%&');
    var title = payload.substring(0, firstIdx);
    payload = payload.substring(firstIdx + 2);
    var secondIdx = payload.indexOf('%&');
    var description = payload.substring(0, secondIdx);
    var time = payload.substring(secondIdx + 2);
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            backgroundColor: Color.fromARGB(255, 37, 37, 37),
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
                Container(height: 10),
                Text(
                  'Timings:-',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Text(
                  time,
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ]);
      },
    );
  }

  // Future _showNotificationWithDefaultSound(
  //     {String title,
  //     String description,
  //     int id,
  //     String payload,
  //     DateTime time}) async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'IITDAPP', 'IITD APP', 'IITD APP Calendar Events',
  //       importance: Importance.Max, priority: Priority.High);
  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.schedule(
  //       id, title, description, time, platformChannelSpecifics,
  //       payload: payload, androidAllowWhileIdle: true);
  // }

  Widget _getAppointmentEditor(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          leading: Text(''),
          title: TextField(
            controller: TextEditingController(text: _subject),
            onChanged: (String value) {
              _subject = value;
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(
                fontSize: 25,
                color:
                    Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR,
                fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR
                      .withOpacity(0.54)),
              hintText: 'Add title',
            ),
          ),
        ),
        const Divider(
          height: 1.0,
          thickness: 1,
        ),
        ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: Icon(
              Icons.access_time,
              color: Provider.of<ThemeModel>(context)
                  .theme
                  .PRIMARY_TEXT_COLOR
                  .withOpacity(0.54),
            ),
            title: Row(children: <Widget>[
              const Expanded(
                child: Text('All-day'),
              ),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Switch(
                        value: _isAllDay,
                        onChanged: (bool value) {
                          setState(() {
                            _isAllDay = value;
                          });
                        },
                      ))),
            ])),
        ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: const Text(''),
            title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: GestureDetector(
                        onTap: () async {
                          var date = await showDatePicker(
                            context: context,
                            initialDate: _startDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          if (date != null && date != _startDate) {
                            setState(() {
                              var difference = _endDate.difference(_startDate);
                              _startDate = DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                  _startTime.hour,
                                  _startTime.minute,
                                  0);
                              _endDate = _startDate.add(difference);
                              _endTime = TimeOfDay(
                                  hour: _endDate.hour, minute: _endDate.minute);
                            });
                          }
                        },
                        child: Text(
                            DateFormat('EEE, MMM dd yyyy').format(_startDate),
                            textAlign: TextAlign.left)),
                  ),
                  Expanded(
                      flex: 3,
                      child: _isAllDay
                          ? const Text('')
                          : GestureDetector(
                              onTap: () async {
                                var time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                        hour: _startTime.hour,
                                        minute: _startTime.minute));

                                if (time != null && time != _startTime) {
                                  setState(() {
                                    _startTime = time;
                                    var difference =
                                        _endDate.difference(_startDate);
                                    _startDate = DateTime(
                                        _startDate.year,
                                        _startDate.month,
                                        _startDate.day,
                                        _startTime.hour,
                                        _startTime.minute,
                                        0);
                                    _endDate = _startDate.add(difference);
                                    _endTime = TimeOfDay(
                                        hour: _endDate.hour,
                                        minute: _endDate.minute);
                                  });
                                }
                              },
                              child: Text(
                                DateFormat('hh:mm a').format(_startDate),
                                textAlign: TextAlign.right,
                              ))),
                ])),
        ListTile(
            contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            leading: const Text(''),
            title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: GestureDetector(
                        onTap: () async {
                          var date = await showDatePicker(
                            context: context,
                            initialDate: _endDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          if (date != null && date != _endDate) {
                            setState(() {
                              var difference = _endDate.difference(_startDate);
                              _endDate = DateTime(date.year, date.month,
                                  date.day, _endTime.hour, _endTime.minute, 0);
                              if (_endDate.isBefore(_startDate)) {
                                _startDate = _endDate.subtract(difference);
                                _startTime = TimeOfDay(
                                    hour: _startDate.hour,
                                    minute: _startDate.minute);
                              }
                            });
                          }
                        },
                        child: Text(
                          DateFormat('EEE, MMM dd yyyy').format(_endDate),
                          textAlign: TextAlign.left,
                        )),
                  ),
                  Expanded(
                      flex: 3,
                      child: _isAllDay
                          ? const Text('')
                          : GestureDetector(
                              onTap: () async {
                                var time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                        hour: _endTime.hour,
                                        minute: _endTime.minute));

                                if (time != null && time != _endTime) {
                                  setState(() {
                                    _endTime = time;
                                    var difference =
                                        _endDate.difference(_startDate);
                                    _endDate = DateTime(
                                        _endDate.year,
                                        _endDate.month,
                                        _endDate.day,
                                        _endTime.hour,
                                        _endTime.minute,
                                        0);
                                    if (_endDate.isBefore(_startDate)) {
                                      _startDate =
                                          _endDate.subtract(difference);
                                      _startTime = TimeOfDay(
                                          hour: _startDate.hour,
                                          minute: _startDate.minute);
                                    }
                                  });
                                }
                              },
                              child: Text(
                                DateFormat('hh:mm a').format(_endDate),
                                textAlign: TextAlign.right,
                              ))),
                ])),
        const Divider(
          height: 1.0,
          thickness: 1,
        ),
        ListTile(
          // Reminder Tile
          contentPadding: const EdgeInsets.all(5),
          leading: Icon(
            Icons.notifications,
            color: Provider.of<ThemeModel>(context)
                .theme
                .PRIMARY_TEXT_COLOR
                .withOpacity(0.87),
          ),
          title: TextField(
            controller: TextEditingController(text: _reminder),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => ReminderPicker(),
              ).then((dynamic value) => setState(() {}));
            },
            onChanged: (String value) {
              _reminder = value;
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(
                fontSize: 18,
                color: Provider.of<ThemeModel>(context)
                    .theme
                    .PRIMARY_TEXT_COLOR
                    .withOpacity(0.87),
                fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR
                      .withOpacity(0.54)),
              hintText: 'Add Reminder',
            ),
          ),
        ),
        ListTile(
          // Location
          contentPadding: const EdgeInsets.all(5),
          leading: Icon(
            Icons.local_airport,
            color: Provider.of<ThemeModel>(context)
                .theme
                .PRIMARY_TEXT_COLOR
                .withOpacity(0.87),
          ),
          title: TextField(
            controller: TextEditingController(text: _location),
            onChanged: (String value) {
              _location = value;
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(
                fontSize: 18,
                color: Provider.of<ThemeModel>(context)
                    .theme
                    .PRIMARY_TEXT_COLOR
                    .withOpacity(0.87),
                fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR
                      .withOpacity(0.54)),
              hintText: 'Add Location',
            ),
          ),
        ),
        ListTile(
          // Attendee
          contentPadding: const EdgeInsets.all(5),
          leading: Icon(
            Icons.people,
            color: Provider.of<ThemeModel>(context)
                .theme
                .PRIMARY_TEXT_COLOR
                .withOpacity(0.87),
          ),
          title: TextField(
            controller: TextEditingController(text: _attendee),
            onChanged: (String value) {
              _attendee = value;
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(
                fontSize: 18,
                color: Provider.of<ThemeModel>(context)
                    .theme
                    .PRIMARY_TEXT_COLOR
                    .withOpacity(0.87),
                fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR
                      .withOpacity(0.54)),
              hintText: 'Add Attendees',
            ),
          ),
        ),
        // ListTile(
        //   // Recurrence
        //   onTap: () {
        //     showDialog(
        //       context: context,
        //       builder: (BuildContext context) => RecurrenceDialog(),
        //     ).then((dynamic value) => setState(() {}));
        //   },
        //   contentPadding: const EdgeInsets.all(5),
        //   leading: Icon(
        //     Icons.repeat,
        //     color: Provider.of<ThemeModel>(context)
        //         .theme
        //         .PRIMARY_TEXT_COLOR
        //         .withOpacity(0.87),
        //   ),
        //   title: Text(
        //     'Repeat',
        //     style: TextStyle(fontSize: 18),
        //   ),
        //   subtitle: Text(
        //     _recurrence,
        //     style: TextStyle(color: Colors.green),
        //   ),
        // ),
        ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: Icon(
            Icons.subject,
            color: Provider.of<ThemeModel>(context)
                .theme
                .PRIMARY_TEXT_COLOR
                .withOpacity(0.87),
          ),
          title: TextField(
            controller: TextEditingController(text: _notes),
            onChanged: (String value) {
              _notes = value;
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(
                fontSize: 18,
                color: Provider.of<ThemeModel>(context)
                    .theme
                    .PRIMARY_TEXT_COLOR
                    .withOpacity(0.87),
                fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR
                      .withOpacity(0.54)),
              hintText: 'Add description',
            ),
          ),
        ),
        const Divider(
          height: 1.0,
          thickness: 1,
        ),
      ],
    );
  }

  @override
  Widget build([BuildContext context]) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context),
        home: Scaffold(
            backgroundColor: Provider.of<ThemeModel>(context, listen: false)
                .theme
                .SCAFFOLD_BACKGROUND,
            appBar: AppBar(
              title: Text(getTile()),
              backgroundColor:
                  Color(_selectedColor), //colorCollection[_selectedColorIndex],
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    icon: const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      // Update or Create Event
                      var isExternalCalendar =
                          _selectedAppointment.calendarId != IITDCalendarId &&
                              _selectedAppointment.calendarId !=
                                  starredCalendarId &&
                              _selectedAppointment.calendarId !=
                                  userEventsCalendarId;

                      var isRecurring = _selectedAppointment != null &&
                          _selectedAppointment.recurrence != null;

                      unawaited(showLoading(context, message: 'Loading'));
                      if (isRecurring && isExternalCalendar) {
                        print('You can quit now');
                        Navigator.pop(context);
                        await showChoiceAlert(
                            context,
                            'Unable to Update Event',
                            'The event was added to your external calendar, cannot be updated from this App!!! You can still update the event in your device\'s default calendar.'
                                'Do you want to open your device calendar?',
                            UrlHandler.launchDeviceCalendar);

                        // await showErrorAlert(context, 'Event Cannot be updated',
                        //     'The event was added to your external calendar, cannot be updated from this App!!! You can still update the event in your device\'s default calendar.');
                        Navigator.pop(context);
                      } else {
                        var meetings = <Meeting>[];

                        var event = Event(
                            _selectedAppointment == null
                                ? userEventsCalendarId
                                : _selectedAppointment.calendarId,
                            start: _startDate,
                            end: _endDate);
                        if (_selectedAppointment != null) {
                          event.eventId = _selectedAppointment.eventId;
                        }
                        event.title = _subject == '' ? '(No title)' : _subject;
                        event.description = _notes;
                        event.location = _location;
                        event.attendees = getAttendeeList(_attendee);
                        event.reminders = getReminderList(_reminder);
                        event.allDay = _isAllDay;
                        event.startTimeZone = '';
                        event.endTimeZone = '';
                        event = addRecurrenceRule(_recurrence, event);
                        var res = '';
                        if (!isExternalCalendar) {
                          res = await postReminder(
                              event, !(_selectedAppointment == null),
                              addToQueue: false);
                          if (res == 'error') {
                            if (_selectedAppointment.calendarId ==
                                starredCalendarId) {
                              // Check if only the reminder has been changed, and everythin else is the same
                              if (_selectedAppointment != null &&
                                  _selectedAppointment.eventName ==
                                      event.title &&
                                  _selectedAppointment.description ==
                                      event.description &&
                                  _selectedAppointment.location ==
                                      event.location &&
                                  _selectedAppointment.isAllDay ==
                                      event.allDay) {
                                print('Reminder can be updated');
                              } else {
                                print('Reminder cannot be updated');
                                Navigator.pop(context);
                                await showErrorAlert(
                                    context,
                                    'Event Cannot be updated',
                                    'For Starred Events, Only reminder time can be updated. If you are admin of this event, you can update the details from Events tab.');
                                Navigator.pop(context);
                                return;
                              }
                              // Now Fetch the Events from server, and see if only the reminder has been changed

                            } else {
                              print('server error occured');
                              Navigator.pop(context);
                              await showErrorAlert(
                                  context,
                                  'Event Cannot be updated',
                                  'Server Error occured. Please try again later');
                              Navigator.pop(context);
                              return;
                            }
                          }
                          if (res == 'timeout') {
                            connectedToInternet = false;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: CustomSnackBarContent(
                                text: 'Unable to connect to server',
                              ),
                            ));
                          }
                        }
                        // event.availability = 'BUSY';
                        var createEventResult = await DeviceCalendarPlugin()
                            .createOrUpdateEvent(event);
                        var prefs = await SharedPreferences.getInstance();
                        if (createEventResult.isSuccess) {
                          if (!isExternalCalendar) {
                            if (res == 'timeout') {
                              QueueManager.addToList({
                                'func': 'postReminder',
                                'event': createPostReminderBody(event),
                                'patch': _selectedAppointment != null,
                                'eventId': createEventResult.data
                              });
                            }
                            if (res != '' &&
                                res != 'timeout' &&
                                res != 'error') {
                              await prefs.setString('ser ' + res,
                                  'loc ' + createEventResult.data);
                            }
                          }
                          if (_selectedAppointment != null) {
                            try {
                              _events.appointments.removeAt(_events.appointments
                                  .indexOf(_selectedAppointment));
                              _events.notifyListeners(
                                  CalendarDataSourceAction.remove,
                                  <Meeting>[_selectedAppointment]);
                            } catch (e) {
                              print(e);
                            }
                            calForceSetsState();
                          }
                          meetings.add(Meeting(
                            eventId: createEventResult.data,
                            from: _startDate,
                            to: _endDate,
                            background: Color(
                                _selectedColor), //colorCollection[_selectedColorIndex],
                            startTimeZone: '',
                            endTimeZone: '',
                            location: _location,
                            attendee: event.attendees,
                            recurrence: event.recurrenceRule,
                            reminder: event.reminders,
                            calendarId: _selectedAppointment == null
                                ? userEventsCalendarId
                                : _selectedAppointment.calendarId,
                            description: _notes,
                            isAllDay: _isAllDay,
                            eventName: _subject == '' ? '(No title)' : _subject,
                          ));
                          print(meetings);
                          _events.appointments.add(meetings[0]);

                          _events.notifyListeners(CalendarDataSourceAction.add,
                              <Meeting>[meetings[0]]);
                          _selectedAppointment = null;
                          calForceSetsState();
                        } else {
                          print('error occured');
                        }
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    })
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Stack(
                children: <Widget>[_getAppointmentEditor(context)],
              ),
            ),
            floatingActionButton: _selectedAppointment == null
                ? const Text('')
                : FloatingActionButton(
                    onPressed: () async {
                      // Dlete the Given Appointment
                      var isExternalCalendar =
                          _selectedAppointment.calendarId != IITDCalendarId &&
                              _selectedAppointment.calendarId !=
                                  starredCalendarId &&
                              _selectedAppointment.calendarId !=
                                  userEventsCalendarId;

                      var isRecurring = _selectedAppointment.recurrence != null;
                      if (isRecurring && isExternalCalendar) {
                        print('User shouldnt delete this');
                        print('Show an appropriate Dialog and return');
                        // Navigator.pop(context);
                        showChoiceAlert(
                            context,
                            'Unable to delete Event',
                            'The event was added from external calendar, cannot be deleted from this App!!! You can still delete the event in your device\'s default calendar.',
                            UrlHandler.launchInBrowser);

                        Navigator.pop(context);
                      } else {
                        unawaited(showLoading(context, message: 'Loading'));
                        if (_selectedAppointment != null) {
                          if (!isExternalCalendar) {
                            var succ = await deleteReminderFromServer(
                                _selectedAppointment.eventId);
                            print('Now out from deleteReminderFromServer');
                            if (succ == -1) {
                              print('unable to connect to server');
                              Navigator.pop(context);
                              await showErrorAlert(
                                  context,
                                  'Cannot Connect to Server',
                                  'Unable to connect to server. Check your internet connection or try again later.');
                              Navigator.pop(context);
                            } else if (succ == 0) {
                              print('Error occured');
                              if (_selectedAppointment.calendarId ==
                                  starredCalendarId) {
                                Navigator.pop(context);
                                await showErrorAlert(
                                    context,
                                    'Event Cannot Be Deleted',
                                    'You can still unstar the event in order to delete it.');
                                Navigator.pop(context);
                              } else {
                                Navigator.pop(context);
                                await showErrorAlert(
                                    context,
                                    'Event Cannot Be Deleted',
                                    'Server Error Occured');
                                Navigator.pop(context);
                              }
                              return;
                            }
                          }
                          var res = await DeviceCalendarPlugin().deleteEvent(
                              _selectedAppointment.calendarId,
                              _selectedAppointment.eventId);
                          if (res.isSuccess) {
                            try {
                              _events.appointments.removeAt(_events.appointments
                                  .indexOf(_selectedAppointment));
                            } catch (e) {
                              print(e);
                            }
                            _events.notifyListeners(
                                CalendarDataSourceAction.remove,
                                <Meeting>[_selectedAppointment]);
                            _selectedAppointment = null;
                            calForceSetsState();
                          } else {
                            print('Error:- Could not delete event');
                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      }
                    },
                    backgroundColor: Colors.red,
                    child:
                        const Icon(Icons.delete_outline, color: Colors.white),
                  )));
  }

  String getTile() {
    return _subject.isEmpty ? 'New event' : 'Event details';
  }
}

Event addRecurrenceRule(var rule, Event event) {
  //verify this function
  // TODO: Currently Forced -> rule = recurrenceOptions[0]
  rule = recurrenceOptions[0];
  if (rule == null || rule == recurrenceOptions[0]) {
    return event;
  }
  RecurrenceFrequency temp;
  if (rule == recurrenceOptions[1]) {
    temp = RecurrenceFrequency.Daily;
  } else if (rule == recurrenceOptions[2]) {
    temp = RecurrenceFrequency.Weekly;
  } else if (rule == recurrenceOptions[3]) {
    temp = RecurrenceFrequency.Monthly;
  } else if (rule == recurrenceOptions[4]) {
    temp = RecurrenceFrequency.Yearly;
  }
  var rRule = RecurrenceRule(temp);
  rRule.interval = 1;
  event.recurrenceRule = rRule;
  return event;
}

List<Attendee> getAttendeeListFromList(var lis) {
  // Check if lis is null and return empty list
  if (lis == null) {
    return [];
  }

  var res = <Attendee>[]; // ignore: prefer_collection_literals
  for (var i = 0; i < lis.length; i++) {
    if (lis[i] == '') {
      continue;
    }
    res.add(Attendee(emailAddress: lis[i]));
  }
  return res;
}

List<Attendee> getAttendeeList(String str) {
  var res = <Attendee>[]; // ignore: prefer_collection_literals
  if (str == '' || str == null) {
    return res;
  }
  var ls = LineSplitter();
  var lines = ls.convert(str);
  for (var i = 0; i < lines.length; i++) {
    res.add(Attendee(name: lines[i], emailAddress: '', isOrganiser: false));
  }
  return res;
}

List<Reminder> getReminderList(String rem) {
  var lis = <Reminder>[];
  if (rem == '' || rem == null) {
    return lis;
  }
  var t = int.parse(rem.substring(0, rem.indexOf(' ')));
  var unit = rem.substring(rem.indexOf(' ') + 1);
  if (unit == 'Minutes') {
    lis.add(Reminder(minutes: t));
  } else if (unit == 'Hours') {
    lis.add(Reminder(minutes: t * 60));
  } else if (unit == 'Days') {
    lis.add(Reminder(minutes: t * 60 * 24));
  } else if (unit == 'Weeks') {
    lis.add(Reminder(minutes: t * 60 * 24 * 7));
  }
  return lis;
}

class ReminderPicker extends StatefulWidget {
  @override
  _ReminderPickerState createState() => _ReminderPickerState();
}

class _ReminderPickerState extends State<ReminderPicker> {
  var type;
  var time;

  @override
  void initState() {
    if (_reminder == '') {
      type = 0;
      time = '10';
    } else {
      time = _reminder.substring(0, _reminder.indexOf(' '));
      var unit = _reminder.substring(_reminder.indexOf(' ') + 1);
      for (var i = 0; i < reminderUnits.length; i++) {
        if (unit == reminderUnits[i]) {
          type = i;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void handleValueChange(var value) {
      setState(() {
        type = value;
      });
    }

    void setReminder(var value) {
      setState(() {
        _reminder = value;
      });
    }

    return Dialog(
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: TextField(
                  controller: TextEditingController(text: time),
                  onChanged: (String value) {
                    time = value;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .PRIMARY_TEXT_COLOR
                            .withOpacity(0.54)),
                    hintText: 'Time',
                  ),
                ),
              ),
              RadioWithText(
                type: type,
                idx: 0,
                func: handleValueChange,
                textArray: reminderUnits,
              ),
              RadioWithText(
                type: type,
                idx: 1,
                func: handleValueChange,
                textArray: reminderUnits,
              ),
              RadioWithText(
                type: type,
                idx: 2,
                func: handleValueChange,
                textArray: reminderUnits,
              ),
              RadioWithText(
                type: type,
                idx: 3,
                func: handleValueChange,
                textArray: reminderUnits,
              ),
              Container(height: 20),
              Row(
                children: <Widget>[
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('CANCEL'),
                  ),
                  TextButton(
                    onPressed: () {
                      setReminder(time + ' ' + reminderUnits[type]);
                      Navigator.pop(context);
                    },
                    child: Text('SAVE'),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}

class RecurrenceDialog extends StatefulWidget {
  @override
  _RecurrenceDialogState createState() => _RecurrenceDialogState();
}

class _RecurrenceDialogState extends State<RecurrenceDialog> {
  var type;

  @override
  void initState() {
    if (_recurrence == '') {
      type = 0;
    } else {
      for (var i = 0; i < recurrenceOptions.length; i++) {
        if (_recurrence == recurrenceOptions[i]) {
          type = i;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void handleValueChange(var value) {
      setState(() {
        type = value;
      });
    }

    void setRecurrence(var value) {
      setState(() {
        _recurrence = value;
      });
    }

    return Dialog(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RadioWithText(
          type: type,
          idx: 0,
          func: handleValueChange,
          textArray: recurrenceOptions,
        ),
        RadioWithText(
          type: type,
          idx: 1,
          func: handleValueChange,
          textArray: recurrenceOptions,
        ),
        RadioWithText(
          type: type,
          idx: 2,
          func: handleValueChange,
          textArray: recurrenceOptions,
        ),
        RadioWithText(
          type: type,
          idx: 3,
          func: handleValueChange,
          textArray: recurrenceOptions,
        ),
        RadioWithText(
          type: type,
          idx: 4,
          func: handleValueChange,
          textArray: recurrenceOptions,
        ),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                setRecurrence(recurrenceOptions[type]);
                Navigator.pop(context);
              },
              child: Text('SAVE'),
            ),
          ],
        )
      ],
    ));
  }
}

// ignore: must_be_immutable
class RadioWithText extends StatelessWidget {
  RadioWithText({this.type, this.idx, this.func, this.textArray});
  var type;
  var idx;
  var func;
  var textArray;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        func(idx);
      },
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        Radio(
          value: idx,
          groupValue: type,
          onChanged: func,
        ),
        Text(textArray[idx], style: TextStyle(fontSize: 16)),
      ]),
    );
  }
}
