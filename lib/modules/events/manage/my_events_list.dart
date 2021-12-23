import 'package:flutter/material.dart';

import './my_event_card.dart';
import '../events/event_class.dart';

class MyEventsList extends StatelessWidget {
  final List<Event> _events;
  final Function _refresh;

  const MyEventsList(this._events, this._refresh);

  @override
  Widget build(BuildContext context) {
    if (_events.isEmpty) {
      return Container(
        padding: EdgeInsets.all(30),
        child: Text(
          'No events',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
          ),
        ),
      );
    }
    return ListView.builder(
      key: PageStorageKey('myEventsList'),
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _events.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (BuildContext context, int index) {
        return MyEventCard(
            _events[index], _refresh, ValueKey(_events[index].eventid));
      },
    );
  }
}
