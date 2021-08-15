import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/cancel_alert.dart';
import 'package:IITDAPP/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pedantic/pedantic.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'dart:async';

import '../events/event_class.dart';

Future<void> addEventRequest(Event event, BuildContext context) async {
  print(event.toMap());
  final response = await http.post('$url/api/events',
      headers: {'authorization': 'Bearer $token'}, body: event.toMap());
  print(event.toMap());
  if (response.statusCode == 200) {
    await Provider.of<EventsTabProvider>(context, listen: false).getData();
    // var parsedJson = json.decode(response.body);
    // if (parsedJson['message'] == 'Event Created Successfully') {
    // Navigator.popUntil(
    //     context, ModalRoute.withName('/events'));

    //Fix this to use named routes
    var count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Event Added'),
    ));
    // } else {
    //   Navigator.pop(context);
    //   scaffoldKey.currentState.showSnackBar(SnackBar(
    //     content: Text('Cannot add event. Try Again'),
    //   ));
    // }
  } else {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
            style: TextStyle(
                color:
                    Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR),
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
                  labelStyle: TextStyle(
                      color: Provider.of<ThemeModel>(context, listen: false)
                          .theme
                          .PRIMARY_TEXT_COLOR
                          .withOpacity(0.5)),
                  helperText: ''),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR),
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
                labelStyle: TextStyle(
                    color: Provider.of<ThemeModel>(context, listen: false)
                        .theme
                        .PRIMARY_TEXT_COLOR
                        .withOpacity(0.5)),
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
                  alignLabelWithHint: true,
                  labelText: 'Venue',
                  labelStyle: TextStyle(
                      color: Provider.of<ThemeModel>(context, listen: false)
                          .theme
                          .PRIMARY_TEXT_COLOR
                          .withOpacity(0.5)),
                  helperText: ''),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR),
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
                  labelStyle: TextStyle(
                      color: Provider.of<ThemeModel>(context, listen: false)
                          .theme
                          .PRIMARY_TEXT_COLOR
                          .withOpacity(0.5)),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  helperText: ''),
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR),
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
                  labelStyle: TextStyle(
                      color: Provider.of<ThemeModel>(context, listen: false)
                          .theme
                          .PRIMARY_TEXT_COLOR
                          .withOpacity(0.5)),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  helperText: ''),
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR),
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
                  labelStyle: TextStyle(
                      color: Provider.of<ThemeModel>(context, listen: false)
                          .theme
                          .PRIMARY_TEXT_COLOR
                          .withOpacity(0.5)),
                  helperText: ''),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onSaved: (text) {
                _about = text;
              },
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR),
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
                  labelStyle: TextStyle(
                      color: Provider.of<ThemeModel>(context, listen: false)
                          .theme
                          .PRIMARY_TEXT_COLOR
                          .withOpacity(0.5)),
                  helperText: ''),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR),
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
                ElevatedButton(
                  onPressed: () {
                    showCancelAlert(context, 'Cancel making new event?',
                        'Are you sure you want discard this event?');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Provider.of<ThemeModel>(context)
                        .theme
                        .RAISED_BUTTON_BACKGROUND,
                  ),
                  child: Text('CANCEL',
                      style: TextStyle(
                          color: Provider.of<ThemeModel>(context)
                              .theme
                              .RAISED_BUTTON_FOREGROUND)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Provider.of<ThemeModel>(context)
                        .theme
                        .RAISED_BUTTON_BACKGROUND,
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
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .RAISED_BUTTON_FOREGROUND),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
