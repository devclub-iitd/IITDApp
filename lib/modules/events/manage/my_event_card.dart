import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import './my_event_info/event_info_screen.dart';
// import '../events/event_info/event_info_screen.dart';
import '../events/event_class.dart';
import '../events/event_card_contents/event_time.dart';
import '../events/event_card_contents/event_venue.dart';
import './edit_event.dart';

class MyEventCard extends StatelessWidget {
  final Event _event;
  final Function _refresh;

  MyEventCard(this._event, this._refresh, Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventInfo(_event)),
        ).then((value) {
          _refresh();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        margin: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
              Expanded(child: 
              Container(
                margin: EdgeInsets.only(bottom: 10, right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      _event.eventName,
                      style: TextStyle(fontSize: 23, color: Colors.white),
                      minFontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.calendar_today),
                tooltip: 'Add to Calendar',
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditEvent(_event)),
                  ).then((value) {
                    _refresh();
                  });
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                tooltip: 'Edit Event Info',
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: EventVenue(_event.venue),
                ),
                Expanded(
                  child: EventTime(_event.startsAt, _event.endsAt),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
