// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/cancel_alert.dart';
import 'package:IITDAPP/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pedantic/pedantic.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';
import '../events/event_class.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

Future<void> addEventRequest(Event event, BuildContext context) async {
  if (event.eventImage == null) {
    var ok = Random();
    var bytes = await rootBundle.load('assets/images/null.png');
    String temp = (await getTemporaryDirectory()).path;
    event.eventImage = File('$temp/imaag' +
        ok.nextInt(1000).toString() +
        ok.nextInt(1000).toString() +
        ok.nextInt(1000).toString() +
        '.png');
    await event.eventImage.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
  }
  print("start");
  var stream =
      http.ByteStream(DelegatingStream.typed(event.eventImage.openRead()));
  var length = await event.eventImage.length();
  var request = http.MultipartRequest("POST", Uri.parse('$uri/api/events'));
  var multipartFile = http.MultipartFile('eventImage', stream, length,
      filename: basename(event.eventImage.path));
  request.files.add(multipartFile);

  // final response = await http.post(
  //   '$uri/api/events',
  //   headers: {'authorization': 'Bearer $token'},
  //   body: event.toMap(),
  // );

  // var responseData = json.decode(response.body);
  // var id = responseData["data"]["_id"];

  request.fields['name'] = event.eventName;
  request.fields['about'] = event.about;
  request.fields['startDate'] =
      event.startsAt.subtract(Duration(minutes: 330)).toIso8601String() + 'Z';
  request.fields['endDate'] =
      event.endsAt.subtract(Duration(minutes: 330)).toIso8601String() + 'Z';
  request.fields['venue'] = event.venue;
  request.fields['body'] = event.eventBody.id;
  // request.fields['eventImage'] = base64image;
  request.headers['authorization'] = 'Bearer $token';
  final response = await request.send();
  print(response.statusCode);
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });

  if (response.statusCode == 200) {
    await Provider.of<EventsTabProvider>(context, listen: false).getData();
    var count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Event Added'),
    ));
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
  File img;
  // String imgpath;
  String _venue;
  UClub selectedClub;
  UClub club;
  DateTime _startsAt;
  DateTime _endsAt;
  String _about;
  String _imageLink;
  List<DropdownMenuItem<UClub>> clubList = [];
  int show = 1;
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
              // color: Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }
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
        return null;
      }
      final perm = File(image.path);
      // final perm = await Perm(image.path);
      setState(() => {img = perm});
    } on PlatformException catch (e) {
      print('failed to pick img $e');
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
                      child: img != null
                          ? Image.file(
                              img,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/null.png',
                            ),
                    ),
                    Text("Image Size : " +
                        (img == null
                            ? '0'
                            : (img.lengthSync() / (1024 * 1024))
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
                    if (img != null && img.lengthSync() / (1024 * 1024) >= 2) {
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
                        var ev = Event(
                          eventName: _eventName,
                          eventBody: selectedClub,
                          venue: _venue,
                          about: _about,
                          start: _startsAt,
                          end: _endsAt,
                          isBodySub: false,
                          isStarred: false,
                          imageLink: _imageLink,
                          eventImage: img,
                        );
                        unawaited(showLoading(context));
                        await addEventRequest(ev, context);
                        // Navigator.popUntil(context,
                        //     ModalRoute.withName(Navigator.defaultRouteName));
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
