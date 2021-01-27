import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/sectionTitle.dart';
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
            SectionTitle(
              title: 'CLUB EVENTS',
            ),
            SectionUnderLine(),
            (_clubEvents.isEmpty)
                ? Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'No Events',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                            color: Provider.of<ThemeModel>(context)
                                .theme
                                .PRIMARY_TEXT_COLOR
                                .withOpacity(0.7)),
                      ),
                    ),
                  )
                : Column(
                    children: _clubEvents
                        .map((element) => ClubEventCard(
                            element, reload, ValueKey(element.eventid)))
                        .toList(),
                  )
          ],
        ),
      ),
    );
  }
}
