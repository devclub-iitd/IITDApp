import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:IITDAPP/modules/events/globals.dart';
import '../event_class.dart';

class StarButton extends StatefulWidget {
  final Event _event;
  final Function _reorderList;

  StarButton(this._event, this._reorderList);

  @override
  State<StatefulWidget> createState() {
    return StarButtonState();
  }
}

class StarButtonState extends State<StarButton> {
  Icon _icon;
  String _toolTip;
  Event _event;
  Function _reorderList;
  Function onpress;

  @override
  void initState() {
    super.initState();
    _reorderList = widget._reorderList;
    _event = widget._event;
    onpress = () {
      onStarPress();
    };
    if (_event.isStarred) {
      _icon = Icon(
        Icons.star,
        color: Colors.amberAccent,
      );
      _toolTip = 'Unstar';
    } else {
      _icon = Icon(
        Icons.star_border,
        color: Colors.white,
      );
      _toolTip = 'Star';
    }
  }

  Future<Null> starEvent(String eventid) async {
    print("Starring Event");
    final response = await http.post(
      "$url/api/events/$eventid/star",
      headers: {"authorization": "Bearer $token"},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      if (parsedJson["message"] == "Successfully Starred") {
        _event.isStarred = !_event.isStarred;
        if (_event.isStarred) {
          _icon = Icon(
            Icons.star,
            color: Colors.amberAccent,
          );
          _toolTip = 'Unstar';
        } else {
          _icon = Icon(
            Icons.star_border,
            color: Colors.white,
          );
          _toolTip = 'Star';
        }
        // refreshLists(_event);
        sortEvents();
        _reorderList();
        onpress = () {
          onStarPress();
        };
        setState(() {});
        Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text(
                (_event.isStarred) ? "Event Starred" : "Event Unstarred")));
        
      }
    } else {
      if (_event.isStarred) {
          _icon = Icon(
            Icons.star,
            color: Colors.amberAccent,
          );
          _toolTip = 'Unstar';
        } else {
          _icon = Icon(
            Icons.star_border,
            color: Colors.white,
          );
          _toolTip = 'Star';
        }
        onpress = () {
          onStarPress();
        };
        setState(() {});
        Scaffold.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text(
                (_event.isStarred) ? "Could not unstar event" : "Could not star event")));
      throw Exception("Failed to star event");
    }
  }

  void onStarPress() {
    setState(() {
      _icon = Icon(
        Icons.star,
        color: Colors.white54,
      );
      onpress = () {};
    });
    starEvent(_event.eventid);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onpress,
      icon: _icon,
      tooltip: _toolTip,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
