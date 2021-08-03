import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../events/event_class.dart';
import '../../events/event_card_contents/event_time.dart';
import '../../events/event_card_contents/event_venue.dart';
import '../edit_event.dart';

class EventInfoCard extends StatelessWidget {
  final Event _event;
  final Function _refresh;

  EventInfoCard(this._event, this._refresh);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Container(
        decoration: BoxDecoration(
            color: Provider.of<ThemeModel>(context)
                .theme
                .DEFAULT_WIDGET_BACKGROUND,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR
                      .withOpacity(0.1))
            ]),
        margin: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20, left: 25, right: 25),
              child: Column(
                children: <Widget>[
                  AutoSizeText(
                    _event.eventName,
                    style: TextStyle(
                        fontSize: 23,
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .PRIMARY_TEXT_COLOR),
                    minFontSize: 18,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 5,
                  ),
                  AutoSizeText(
                    _event.eventBody.clubName,
                    style: TextStyle(
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .PRIMARY_TEXT_COLOR,
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
                Container(
                  width: 150,
                  child: EventVenue(_event.venue),
                ),
                Container(
                  padding:
                      EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 20),
                  child: EventTime(_event.startsAt, _event.endsAt),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.calendar_today),
                    color: Provider.of<ThemeModel>(context)
                        .theme
                        .PRIMARY_TEXT_COLOR,
                    tooltip: 'Add to Calendar',
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditEvent(_event)),
                      ).then((value) {
                        _refresh();
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Provider.of<ThemeModel>(context)
                          .theme
                          .RAISED_BUTTON_BACKGROUND,
                    ),
                    child: Text(
                      'EDIT EVENT',
                      style: TextStyle(
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .RAISED_BUTTON_FOREGROUND,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
