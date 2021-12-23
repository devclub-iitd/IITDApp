import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
import 'package:IITDAPP/modules/events/events/event_info/update_calendar.dart';
import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:pedantic/pedantic.dart';
// import 'package:IITDAPP/modules/events/globals.dart';
import '../event_class.dart';

class StarButton extends StatefulWidget {
  final Event _event;
  // final Function _reorderList;

  const StarButton(this._event);

  @override
  State<StatefulWidget> createState() {
    return StarButtonState();
  }
}

class StarButtonState extends State<StarButton> {
  Icon _icon;
  String _toolTip;
  Event _event;
  // Function _reorderList;
  Function onpress;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    // _reorderList = widget._reorderList;
    // _event = Provider.of<EventsTabProvider>(context).allEvents.firstWhere((element) => element.eventid == widget._event.eventid);
    _event = widget._event;
    isLoading = false;
    // onpress = () {
    //   onStarPress();
    // };
  }

  Future<void> starEvent(String eventid) async {
    var workingEvent = Provider.of<EventsTabProvider>(context, listen: false)
        .allEvents
        .firstWhere((element) => element.eventid == widget._event.eventid);
    print('Starring Event');
    var timeOutFlag = false;
    final response = await http.post(
      '$uri/api/events/$eventid/star',
      headers: {'authorization': 'Bearer $token'},
    ).timeout(Duration(seconds: 5), onTimeout: () {
      timeOutFlag = true;
      return null;
    });
    if (timeOutFlag) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cannot connect to server'),
      ));
      return;
    }
    print(response.statusCode);
    if (response.statusCode == 200) {
      unawaited(updateCalendar());
      var parsedJson = json.decode(response.body);
      if (parsedJson['message'] == 'Successfully Starred') {
        Provider.of<EventsTabProvider>(context, listen: false)
            .toggleEventStar(eventid);
        _event.isStarred = workingEvent.isStarred;
        // if (_event.isStarred) {
        //   _icon = Icon(
        //     Icons.star,
        //     color: Colors.amberAccent,
        //   );
        //   _toolTip = 'Unstar';
        // } else {
        //   _icon = Icon(
        //     Icons.star_border,
        //     color: Provider.of<ThemeModel>(context, listen: false)
        //         .theme
        //         .PRIMARY_TEXT_COLOR,
        //   );
        //   _toolTip = 'Star';
        // }
        // // refreshLists(_event);
        // // unawaited(sortEvents());
        // // _reorderList();
        // onpress = () {
        //   onStarPress();
        // };
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Text((workingEvent.isStarred)
                ? 'Event Starred'
                : 'Event Unstarred')));
      }
    } else {
      _event.isStarred = workingEvent.isStarred;
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text((workingEvent.isStarred)
              ? 'Could not unstar event'
              : 'Could not star event')));
      throw Exception('Failed to star event');
    }
  }

  void onStarPress() {
    setState(() {
      isLoading = true;
    });
    starEvent(_event.eventid);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      _icon = Icon(
        Icons.star,
        color: Provider.of<ThemeModel>(context, listen: false)
            .theme
            .PRIMARY_TEXT_COLOR
            .withOpacity(0.54),
      );
      onpress = () {};
    } else if (_event.isStarred) {
      _icon = Icon(
        Icons.star,
        color: Colors.amberAccent,
      );
      _toolTip = 'Unstar';
      onpress = () {
        onStarPress();
      };
    } else {
      _icon = Icon(
        Icons.star_border,
        color: Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR,
      );
      _toolTip = 'Star';
      onpress = () {
        onStarPress();
      };
    }
    return IconButton(
      onPressed: onpress,
      icon: _icon,
      tooltip: _toolTip,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
