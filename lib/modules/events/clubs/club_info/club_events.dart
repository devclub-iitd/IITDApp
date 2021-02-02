import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
// import 'package:IITDAPP/modules/events/globals.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/sectionTitle.dart';
import 'package:flutter/material.dart';

import '../../events/event_class.dart';
import './club_event_card.dart';

class ClubEvents extends StatelessWidget {
  final String _clubId;

  ClubEvents(this._clubId);

  @override
  Widget build(BuildContext context) {
    return Consumer<EventsTabProvider>(builder: (context, provider, child) {
      var _clubEvents = provider.allEvents.where((element) => element.eventBody.id == _clubId);
      var _upcomingEvents = _clubEvents
          .where((element) => element.endsAt.isAfter(DateTime.now()))
          .toList();
      var _pastEvents = _clubEvents
          .where((element) => element.endsAt.isBefore(DateTime.now()))
          .toList();
      _upcomingEvents.sort((a, b) {
        if (a.isStarred != b.isStarred) return (a.isStarred) ? 0 : 1;
        return a.startsAt.compareTo(b.startsAt);
      });
      _pastEvents.sort((a, b) {
        if (a.isStarred != b.isStarred) return (a.isStarred) ? 0 : 1;
        return b.endsAt.compareTo(a.endsAt);
      });
      return DefaultTabController(
        length: 2,
        child: FractionallySizedBox(
            widthFactor: 1,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SectionTitle(
                        title: 'CLUB EVENTS',
                      ),
                      SectionUnderLine(),
                      Container(
                        margin: EdgeInsets.only(bottom: 2),
                        decoration: BoxDecoration(
                            color: Provider.of<ThemeModel>(context)
                                .theme
                                .DEFAULT_WIDGET_BACKGROUND,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  color: Provider.of<ThemeModel>(context)
                                      .theme
                                      .PRIMARY_TEXT_COLOR
                                      .withOpacity(0.1))
                            ]),
                        child: TabBar(
                          labelColor:
                              Theme.of(context).primaryColor,
                          unselectedLabelColor: Theme.of(context)
                              .textTheme
                              .headline1
                              .color
                              .withOpacity(0.9),
                          tabs: [
                            Tab(
                              text: 'Upcoming',
                            ),
                            Tab(
                              text: 'Past',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: 
                          TabBarView(children: [
                        _clubEventsList(_upcomingEvents, context),
                        _clubEventsList(_pastEvents, context)
                      ]))
                      // (_clubEvents.isEmpty)
                      //     ? Center(
                      //         child: Container(
                      //           margin: EdgeInsets.only(top: 20),
                      //           child: Text(
                      //             'No Events',
                      //             textAlign: TextAlign.center,
                      //             style: TextStyle(
                      //                 fontSize: 25,
                      //                 fontWeight: FontWeight.w200,
                      //                 color: Provider.of<ThemeModel>(context)
                      //                     .theme
                      //                     .PRIMARY_TEXT_COLOR
                      //                     .withOpacity(0.7)),
                      //           ),
                      //         ),
                      //       )
                      //     : Column(
                      //         children: _clubEvents
                      //             .map((element) => ClubEventCard(
                      //                 element, reload, ValueKey(element.eventid)))
                      //             .toList(),
                      //       )
                    ],
                  )),
            )),
      );
    });
  }
}

Widget _clubEventsList(List<Event> _eventsList, BuildContext context) {
  return (_eventsList.isEmpty)
      ? Center(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'No Events',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w200,
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR
                      .withOpacity(0.7)),
            ),
          ),
        )
      : ListView(
          children: _eventsList
              .map((element) =>
                  ClubEventCard(element, null, ValueKey(element.eventid)))
              .toList(),
        );
}
