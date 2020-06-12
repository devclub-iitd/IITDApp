import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../event_class.dart';
import '../event_card_contents/event_time.dart';
import '../event_card_contents/event_venue.dart';
import '../../clubs/club_info/club_info.dart';
import './star_button.dart';

class EventInfoCard extends StatelessWidget {
  final Event _event;
  final Function _refreshLists;
  final bool showButton;

  EventInfoCard(this._event, this._refreshLists, {this.showButton = true});
  @override
  Widget build(BuildContext context) {
    var actionRow = <Widget>[];
    actionRow.add(IconButton(
      onPressed: () {},
      icon: Icon(Icons.calendar_today),
      tooltip: 'Add to Calendar',
      color: Colors.white,
      iconSize: 20,
    ));
    actionRow.add(
      StarButton(_event, _refreshLists),
    );
    if (showButton) {
      actionRow.add(FlatButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ClubInfo(_event.eventBody)));
        },
        child: Text('SEE CLUB'),
        color: Colors.indigo[400],
        textColor: Colors.white,
      ));
    }
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        margin: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20, left: 25, right: 25),
              child: Column(
                children: <Widget>[
                  AutoSizeText(
                    _event.eventName,
                    style: TextStyle(fontSize: 23, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 5,
                  ),
                  AutoSizeText(
                    _event.eventBody.clubName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(width: 150, child: EventVenue(_event.venue)),
                Container(
                    padding: EdgeInsets.only(
                        bottom: 10, top: 10, left: 10, right: 20),
                    child: EventTime(_event.startsAt, _event.endsAt)),
              ],
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: actionRow
              ),
            ),
          ],
        ),
      ),
    );
  }
}
