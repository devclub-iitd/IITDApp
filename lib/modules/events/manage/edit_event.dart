// ignore_for_file: deprecated_member_use

import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
// import 'package:IITDAPP/routes/Routes.dart';
import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/error_alert.dart';
import 'package:IITDAPP/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:pedantic/pedantic.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../events/event_class.dart';
//import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

Future<void> deleteEvent(BuildContext context, String id) async {
  print('Deleting Event');
  final response = await http
      .post('$uri/api/events/$id', headers: {'authorization': 'Bearer $token'});
  print(response.statusCode);
  print(response.reasonPhrase);
  if (response.statusCode == 200) {
    // var count = 0;
    // Navigator.of(context).popUntil((_) => count++ >= 3);
    await Provider.of<EventsTabProvider>(context, listen: false).getData();
    Navigator.of(context).popUntil((route) => route.isFirst);
    // Navigator.popUntil(context, ModalRoute.withName(Routes.events));
    // await Navigator.pushReplacementNamed(context, Routes.events);
  } else {
    Navigator.pop(context);
    Navigator.pop(context);
    await showErrorAlert(
        context, 'Could not delete', 'Something went wrong. Please try again.');
  }
}

class EditEvent extends StatelessWidget {
  final Event _event;

  const EditEvent(this._event);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _showCancelAlert(context),
      child: Scaffold(
        backgroundColor:
            Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
        appBar: AppBar(
          title: Text('Edit Event'),
          centerTitle: true,
          backgroundColor: Provider.of<ThemeModel>(context).theme.APP_BAR_START,
          // backgroundColorEnd:
          //     Provider.of<ThemeModel>(context).theme.APP_BAR_END,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          behavior: HitTestBehavior.opaque,
          child: ListView(
            children: <Widget>[EditEventForm(_event)],
          ),
        ),
      ),
    );
  }
}

class EditEventForm extends StatefulWidget {
  final Event _event;

  const EditEventForm(this._event);

  @override
  State<StatefulWidget> createState() {
    return _EditEventFormState();
  }
}

class _EditEventFormState extends State<EditEventForm> {
  String _eventName;
  String _venue;
  DateTime _startsAt;
  DateTime _endsAt;
  String _about;
  File _img;

  Event _event;

  @override
  void initState() {
    super.initState();
    _event = widget._event;
    _img = _event.eventImage;
  }

  Future pickImage(int crr) async {
    try {
      print("picking image");
      var image;
      if (crr == 0) {
        image = await ImagePicker.pickImage(
            source: ImageSource.camera, maxHeight: 1500, maxWidth: 1500);
      } else {
        image = await ImagePicker.pickImage(
            source: ImageSource.gallery, maxHeight: 1500, maxWidth: 1500);
      }
      if (image == null) {
        return;
      }
      final perm = File(image.path);
      // final perm = await Perm(image.path);
      setState(() => {_img = perm});
    } on PlatformException catch (e) {
      print('failed to pick img $e');
    }
  }

  Future editEvent() async {
    print('Editing event');
    print(_event.eventid);

    var stream =
        http.ByteStream(DelegatingStream.typed(_event.eventImage.openRead()));
    var length = await _event.eventImage.length();
    String goto = '$uri/api/events/${_event.eventid}';
    print(goto);
    var request = http.MultipartRequest("PUT", Uri.parse(goto));
    var multipartFile = http.MultipartFile('eventImage', stream, length,
        filename: basename(_event.eventImage.path));
    request.files.add(multipartFile);

    request.fields['name'] = _event.eventName;
    request.fields['about'] = _event.about;
    request.fields['startDate'] =
        _event.startsAt.subtract(Duration(minutes: 330)).toIso8601String() +
            'Z';
    request.fields['endDate'] =
        _event.endsAt.subtract(Duration(minutes: 330)).toIso8601String() + 'Z';
    request.fields['venue'] = _event.venue;
    // request.fields['eventImage'] = base64image;
    request.headers['authorization'] = 'Bearer $token';

    final response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    if (response.statusCode == 200) {
      await Provider.of<EventsTabProvider>(this.context, listen: false)
          .getData();
      Navigator.pop(this.context);
    } else {
      Navigator.pop(this.context);
      await showErrorAlert(
          this.context, 'Failed', 'Something went wrong. Please try again');
    }
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                helperText: '',
                alignLabelWithHint: true,
                labelText: 'Event Name',
                labelStyle: TextStyle(
                    color: Provider.of<ThemeModel>(context, listen: false)
                        .theme
                        .PRIMARY_TEXT_COLOR
                        .withOpacity(0.5)),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR),
              initialValue: _event.eventName,
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
            TextFormField(
              initialValue: _event.venue,
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
              initialValue: _event.startsAt,
              // inputType: InputType.both,
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
              format: DateFormat("d MMMM, yyyy 'at' h:mm a"),
              // editable: false,
              // firstDate: DateTime.now(),
              readOnly: true,
              decoration: InputDecoration(
                helperText: '',
                alignLabelWithHint: true,
                labelText: 'Starts At',
                labelStyle: TextStyle(
                    color: Provider.of<ThemeModel>(context, listen: false)
                        .theme
                        .PRIMARY_TEXT_COLOR
                        .withOpacity(0.5)),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR),
              onSaved: (dt) {
                _startsAt = dt;
              },
              validator: (dt) {
                if (dt == null) {
                  _startsAt = null;
                  return 'Required';
                } else {
                  _startsAt = dt;
                  return null;
                }
              },
            ),
            DateTimeField(
              initialValue: _event.endsAt,
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
                helperText: '',
                alignLabelWithHint: true,
                labelText: 'Ends At',
                labelStyle: TextStyle(
                    color: Provider.of<ThemeModel>(context, listen: false)
                        .theme
                        .PRIMARY_TEXT_COLOR
                        .withOpacity(0.5)),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR),
              onSaved: (dt) {
                _endsAt = dt;
              },
              validator: (dt) {
                if (dt == null) {
                  return 'Required';
                } else if (_startsAt != null && dt.isBefore(_startsAt)) {
                  return 'Event should end after it starts';
                  // } else if (dt.isBefore(DateTime.now())) {
                  //   return 'Event has already ended';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              initialValue: _event.about,
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
            Row(
              children: [
                Container(
                  // color: Colors.red,
                  margin: EdgeInsets.fromLTRB(10, 20, 0, 50),
                  child: Column(
                    children: [
                      Card(
                        // color: Colors.grey.shade900,
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .RAISED_BUTTON_BACKGROUND,
                        elevation: 10,
                        shadowColor: Colors.grey.shade900.withBlue(10),
                        child: Container(
                          // color: Colors.red,
                          width: 140,
                          padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                          child: TextButton(
                            onPressed: () => pickImage(0),
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.camera,
                                  size: 24,
                                  // color: Colors.grey.shade600,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Open Camera",
                                  style: TextStyle(
                                    //color: Colors.grey.shade600
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      Card(
                        elevation: 10,
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .RAISED_BUTTON_BACKGROUND,
                        // color: Colors.cyan.shade300,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          width: 140,
                          child: TextButton(
                            onPressed: () => pickImage(1),
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.square_on_square,
                                  size: 24,
                                  // color: Colors.grey.shade600,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Open Gallery",
                                  style: TextStyle(
                                    //color: Colors.grey.shade600
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                    Container(
                      // color: Colors.blue,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      height: 120,
                      width: 180,
                      child: _img != null
                          ? Image.file(
                              _img,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/null.png',
                            ),
                    ),
                    Text("Image Size : " +
                        (_img == null
                            ? '0'
                            : (_img.lengthSync() / (1024 * 1024))
                                .toStringAsFixed(2)) +
                        " mb"),
                    Text("Maximum Allowed Size : 2mb"),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _showDeleteAlert(context, _event);
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red[30]),
                  child: Text(
                    'DELETE',
                    style: TextStyle(
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .RAISED_BUTTON_FOREGROUND),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showCancelAlert(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Provider.of<ThemeModel>(context)
                        .theme
                        .RAISED_BUTTON_BACKGROUND,
                  ),
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                      color: Provider.of<ThemeModel>(context)
                          .theme
                          .RAISED_BUTTON_FOREGROUND,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Provider.of<ThemeModel>(context)
                        .theme
                        .RAISED_BUTTON_BACKGROUND,
                  ),
                  onPressed: () async {
                    if (_img != null &&
                        _img.lengthSync() / (1024 * 1024) >= 2) {
                      AlertDialog alert = AlertDialog(
                        title: Text("Invalid Image"),
                        content:
                            Text("Image Size Exceeds Maximum Allowed Size"),
                        actions: [],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    } else {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        _event.eventName = _eventName;
                        _event.venue = _venue;
                        _event.about = _about;
                        _event.startsAt = _startsAt;
                        _event.endsAt = _endsAt;
                        _event.eventImage = _img;
                        unawaited(showLoading(context));
                        await editEvent();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
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

Future<bool> _showCancelAlert(BuildContext context) {
  return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:
                Provider.of<ThemeModel>(context).theme.ALERT_DIALOG,
            title: Text(
              'Cancel editing',
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .ALERT_DIALOG_TEXT
                      .withOpacity(0.7)),
              // style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Are you sure you want to discard new changes?',
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .ALERT_DIALOG_TEXT
                      .withOpacity(0.7)),
              // style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'NO',
                  style: TextStyle(
                      color: Provider.of<ThemeModel>(context)
                          .theme
                          .ALERT_DIALOG_TEXT
                          .withOpacity(0.7)),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'YES',
                  style: TextStyle(
                      color: Provider.of<ThemeModel>(context)
                          .theme
                          .ALERT_DIALOG_TEXT
                          .withOpacity(0.7)),
                ),
              )
            ],
          );
        },
      ) ??
      false;
}

void _showDeleteAlert(BuildContext context, Event _event) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Provider.of<ThemeModel>(context).theme.ALERT_DIALOG,
        title: Text(
          'Delete Event',
          style: TextStyle(
              color: Provider.of<ThemeModel>(context).theme.ALERT_DIALOG_TEXT),
        ),
        content: Text(
          'Are you sure you want to delete this event?',
          style: TextStyle(
              color: Provider.of<ThemeModel>(context).theme.ALERT_DIALOG_TEXT),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'NO',
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .ALERT_DIALOG_TEXT
                      .withOpacity(0.7)),
            ),
          ),
          TextButton(
            onPressed: () async {
              // Navigator.pop(context);
              unawaited(showLoading(context, message: 'Deleting Event'));
              await deleteEvent(context, _event.eventid);
            },
            child: Text(
              'YES',
              style: TextStyle(color: Colors.red[300]),
            ),
          )
        ],
      );
    },
  );
}
