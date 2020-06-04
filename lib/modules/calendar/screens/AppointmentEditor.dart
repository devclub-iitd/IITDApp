part of event_calendar;

class AppointmentEditor extends StatefulWidget {
  @override
  AppointmentEditorState createState() => AppointmentEditorState();
}

class AppointmentEditorState extends State<AppointmentEditor> {
  var reminder;
  var recurrence;

  @override
  void initState() {
    super.initState();
  }

  Widget _getAppointmentEditor(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(
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
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: InputBorder.none,
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
                  color: Colors.black54,
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
                            child: Text(
                                DateFormat('EEE, MMM dd yyyy')
                                    .format(_startDate),
                                textAlign: TextAlign.left),
                            onTap: () async {
                              var date = await showDatePicker(
                                context: context,
                                initialDate: _startDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              if (date != null && date != _startDate) {
                                setState(() {
                                  var difference =
                                      _endDate.difference(_startDate);
                                  _startDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      _startTime.hour,
                                      _startTime.minute,
                                      0);
                                  _endDate = _startDate.add(difference);
                                  _endTime = TimeOfDay(
                                      hour: _endDate.hour,
                                      minute: _endDate.minute);
                                });
                              }
                            }),
                      ),
                      Expanded(
                          flex: 3,
                          child: _isAllDay
                              ? const Text('')
                              : GestureDetector(
                                  child: Text(
                                    DateFormat('hh:mm a').format(_startDate),
                                    textAlign: TextAlign.right,
                                  ),
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
                                  })),
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
                            child: Text(
                              DateFormat('EEE, MMM dd yyyy').format(_endDate),
                              textAlign: TextAlign.left,
                            ),
                            onTap: () async {
                              var date = await showDatePicker(
                                context: context,
                                initialDate: _endDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );

                              if (date != null && date != _endDate) {
                                setState(() {
                                  var difference =
                                      _endDate.difference(_startDate);
                                  _endDate = DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      _endTime.hour,
                                      _endTime.minute,
                                      0);
                                  if (_endDate.isBefore(_startDate)) {
                                    _startDate = _endDate.subtract(difference);
                                    _startTime = TimeOfDay(
                                        hour: _startDate.hour,
                                        minute: _startDate.minute);
                                  }
                                });
                              }
                            }),
                      ),
                      Expanded(
                          flex: 3,
                          child: _isAllDay
                              ? const Text('')
                              : GestureDetector(
                                  child: Text(
                                    DateFormat('hh:mm a').format(_endDate),
                                    textAlign: TextAlign.right,
                                  ),
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
                                  })),
                    ])),
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              leading: Icon(Icons.lens, color: Color(_selectedColor)),
              title: Text(
                colorCollection[_selectedColorIndex] == Color(_selectedColor)
                    ? colorNames[_selectedColorIndex]
                    : '',
              ),
              onTap: () {
                showDialog<Widget>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return _ColorPicker();
                  },
                ).then((dynamic value) => setState(() {}));
              },
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
            ListTile(
              // Reminder Tile
              contentPadding: const EdgeInsets.all(5),
              leading: Icon(
                Icons.notifications,
                color: Colors.black87,
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
                    color: Colors.black87,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add Reminder',
                ),
              ),
            ),
            ListTile(
              // Location
              contentPadding: const EdgeInsets.all(5),
              leading: Icon(
                Icons.local_airport,
                color: Colors.black87,
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
                    color: Colors.black87,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add Location',
                ),
              ),
            ),
            ListTile(
              // Attendee
              contentPadding: const EdgeInsets.all(5),
              leading: Icon(
                Icons.people,
                color: Colors.black87,
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
                    color: Colors.black87,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add Attendee',
                ),
              ),
            ),
            ListTile(
              // Attendee
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => RecurrenceDialog(),
                ).then((dynamic value) => setState(() {}));
              },
              contentPadding: const EdgeInsets.all(5),
              leading: Icon(
                Icons.repeat,
                color: Colors.black87,
              ),
              title: Text(
                'Repeat',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text(
                _recurrence,
                style: TextStyle(color: Colors.green),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(5),
              leading: Icon(
                Icons.subject,
                color: Colors.black87,
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
                    color: Colors.black87,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add description',
                ),
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 1,
            ),
          ],
        ));
  }

  @override
  Widget build([BuildContext context]) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                      var meetings = <Meeting>[];
                      if (_selectedAppointment != null) {
                        _events.appointments.removeAt(
                            _events.appointments.indexOf(_selectedAppointment));
                        _events.notifyListeners(CalendarDataSourceAction.remove,
                            <Meeting>[]..add(_selectedAppointment));
                      }
                      var event = Event(
                          _selectedAppointment == null
                              ? userEventsCalendarId
                              : _selectedAppointment.calendarId,
                          start: _startDate,
                          end: _endDate);
                      if(_selectedAppointment!=null){
                        event.eventId = _selectedAppointment.eventId;
                      }
                      event.title = _subject == '' ? '(No title)' : _subject;
                      event.description = _notes;
                      event.location = _location;
                      event.attendees = getAttendeeList(_attendee);
                      event.reminders = getReminderList(_reminder);
                      event.allDay = _isAllDay;
                      event = addRecurrenceRule(_recurrence, event);
                      var createEventResult = await DeviceCalendarPlugin()
                          .createOrUpdateEvent(event);
                      if (createEventResult.isSuccess) {
                        meetings.add(Meeting(
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

                        _events.notifyListeners(
                            CalendarDataSourceAction.add, meetings);
                        _selectedAppointment = null;
                      } else {
                        print('error occured');
                      }
                      Navigator.pop(context);
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
                      if (_selectedAppointment != null) {
                        var res = await DeviceCalendarPlugin().deleteEvent(
                            _selectedAppointment.calendarId,
                            _selectedAppointment.eventId);
                        if (res.isSuccess) {
                          _events.appointments.removeAt(_events.appointments
                              .indexOf(_selectedAppointment));
                          _events.notifyListeners(
                              CalendarDataSourceAction.remove,
                              <Meeting>[]..add(_selectedAppointment));
                          _selectedAppointment = null;
                        } else {
                          print('Error:- Could not delete event');
                        }
                        Navigator.pop(context);
                      }
                    },
                    child:
                        const Icon(Icons.delete_outline, color: Colors.white),
                    backgroundColor: Colors.red,
                  )));
  }

  String getTile() {
    return _subject.isEmpty ? 'New event' : 'Event details';
  }
}

Event addRecurrenceRule(var rule, Event event) {
  //verify this function
  if (rule == recurrenceOptions[0]) {
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



List<Attendee> getAttendeeList(var str) {
  var ls = LineSplitter();
  var lines = ls.convert(str);
  var res = List<Attendee>(); // ignore: prefer_collection_literals
  for (var i = 0; i < lines.length; i++) {
    res.add(Attendee(emailAddress: lines[i]));
  }
  return res;
}

List<Reminder> getReminderList(String rem) {
  var lis = <Reminder>[];
  if (rem == '') {
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

    if(_reminder==''){
      type = 0;
      time = '10';
    }
    else{
      time = _reminder.substring(0, _reminder.indexOf(' '));
      var unit = _reminder.substring(_reminder.indexOf(' ') + 1);
      for (var i = 0;i<reminderUnits.length;i++){
        if(unit==reminderUnits[i]) {
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
                      color: Colors.black87,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
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
                  FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('SAVE'),
                    onPressed: () {
                      setReminder(time + ' ' + reminderUnits[type]);
                      Navigator.pop(context);
                    },
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

    if(_recurrence==''){
      type = 0;
    }
    else{
      for (var i = 0;i<recurrenceOptions.length;i++){
        if(_recurrence==reminderUnits[i]) {
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
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('SAVE'),
              onPressed: () {
                setRecurrence(recurrenceOptions[type]);
                Navigator.pop(context);
              },
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
