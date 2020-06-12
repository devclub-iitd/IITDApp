import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:IITDAPP/widgets/cancel_alert.dart';
import 'package:IITDAPP/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pedantic/pedantic.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../events/event_class.dart';

Future<Event> addEventRequest(Event event, BuildContext context) async {
  print(event.toMap());
  final response = await http.post('$url/api/events',
      headers: {'authorization': 'Bearer $token'}, body: event.toMap());
  print(event.toMap());
  if (response.statusCode == 200) {
    var parsedJson = json.decode(response.body);
    if (parsedJson['message'] == 'Event Created Successfully') {
      Navigator.popUntil(
          context, ModalRoute.withName(Navigator.defaultRouteName));
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Event Added'),
      ));
    } else {
      Navigator.pop(context);
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Cannot add event. Try Again'),
      ));
    }
    return Event.fromJson(parsedJson);
  } else {
    Navigator.pop(context);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Cannot add event. Try Again'),
    ));
    throw Exception('Failed to add event');
  }
}

class EventForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EventFormState();
  }
}

class _EventFormState extends State<EventForm> {
  String _eventName;
  // String _eventBody;
  String _venue;
  UClub selectedClub;
  UClub club;
  DateTime _startsAt;
  DateTime _endsAt;
  String _about;
  String _imageLink;
  List<DropdownMenuItem<UClub>> clubList = [];

  final _key = GlobalKey<FormState>();

  void makeList() {
    clubList = [];
    for (var i = 0; i < currentUser.adminof.length; i++) {
      clubList.add(
        DropdownMenuItem<UClub>(
          value: currentUser.adminof[i],
          child: Text(
            currentUser.adminof[i].clubName,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    makeList();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Event Name',
                  helperText: ''),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(color: Colors.white),
              onSaved: (text) {
                _eventName = text;
              },
              validator: (text) {
                if (text.isEmpty) {
                  return 'Required';
                } else {
                  return null;
                }
              },
            ),
            DropdownButtonFormField<UClub>(
              // hint: Text("Select Club"),
              value: selectedClub,
              items: clubList,
              validator: (value) {
                if (value == null ?? true) {
                  return 'Required';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                selectedClub = value;
              },
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Organizer',
                  helperText: '',
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
              onChanged: (value) {
                setState(() {
                  selectedClub = value;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  alignLabelWithHint: true, labelText: 'Venue', helperText: ''),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(color: Colors.white),
              onSaved: (text) {
                _venue = text;
              },
              validator: (text) {
                if (text.isEmpty) {
                  return 'Required';
                } else {
                  return null;
                }
              },
            ),
            DateTimeField(
              // inputType: InputType.both,
              format: DateFormat("d MMMM, yyyy 'at' h:mm a"),
              readOnly: true,
              // editable: false,
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Starts At',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  helperText: ''),
              style: TextStyle(color: Colors.white),
              onChanged: (dt) {
                _endsAt = dt;
              },
              onSaved: (dt) {
                _startsAt = dt;
              },
              validator: (dt) {
                if (dt == null) {
                  return 'Required';
                } else {
                  return null;
                }
              },
            ),
            DateTimeField(
              // inputType: InputType.both,
              format: DateFormat("d MMMM, yyyy 'at' h:mm a"),
              // editable: false,
              readOnly: true,
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Ends At',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  helperText: ''),
              style: TextStyle(color: Colors.white),
              onChanged: (dt) {
                _endsAt = dt;
              },
              onSaved: (dt) {
                _endsAt = dt;
              },
              validator: (dt) {
                if (dt == null) {
                  return 'Required';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Event About',
                  helperText: ''),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onSaved: (text) {
                _about = text;
              },
              style: TextStyle(color: Colors.white),
              validator: (text) {
                if (text.isEmpty) {
                  return 'Required';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Image Link',
                  helperText: ''),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(color: Colors.white),
              onSaved: (text) {
                _imageLink = text;
              },
              validator: (text) {
                if (text.isEmpty || isURL(text)) {
                  return null;
                } else {
                  return 'Not a valid URL';
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    showCancelAlert(context, 'Cancel making new event?', 'Are you sure you want discard this event?');
                  },
                  child: Text('CANCEL'),
                  color: Colors.indigo[400],
                ),
                RaisedButton(
                  color: Colors.indigo[500],
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_key.currentState.validate()) {
                      _key.currentState.save();
                      var ev = Event(
                          eventName: _eventName,
                          eventBody: selectedClub,
                          venue: _venue,
                          about: _about,
                          start: _startsAt,
                          end: _endsAt,
                          isBodySub: false,
                          isStarred: false,
                          imageLink: _imageLink);
                      // Scaffold.of(context).showSnackBar(SnackBar(
                      //   duration: Duration(minutes: 5),
                      //   content: Text("Adding Event"),
                      // ));
                      unawaited(showLoading(context));
                      await addEventRequest(ev, context);
                      // Navigator.popUntil(context,
                      //     ModalRoute.withName(Navigator.defaultRouteName));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
