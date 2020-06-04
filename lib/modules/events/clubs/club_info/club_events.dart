import 'package:flutter/material.dart';

import '../../events/event_class.dart';
import './club_event_card.dart';

class ClubEvents extends StatelessWidget {
  final Function reload;
  final List<Event> _clubEvents;

  ClubEvents(this._clubEvents, this.reload);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'CLUB EVENTS',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  letterSpacing: 4),
            ),
            Container(
              height: 3,
              width: 60,
              margin: EdgeInsets.symmetric(vertical: 10),
              color: Colors.blue,
            ),
            (_clubEvents.length == 0)
                ? Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "No Events",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  )
                : Column(
                    children: _clubEvents
                        .map((element) => ClubEventCard(element, reload, ValueKey(element.eventid)))
                        .toList(),
                  )
          ],
        ),
      ),
    );
  }
}
