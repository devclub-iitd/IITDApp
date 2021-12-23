import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/sectionTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './event_card.dart';
import './event_class.dart';

class EventsList extends StatelessWidget {
  final List<Event> _events;
  // final String _key;
  final String listTitle;
  final Function _onStarPress;

  const EventsList(
    this._events,
    this.listTitle,
    // this._key,
    this._onStarPress,
  );

  Widget renderList(context) {
    if (_events.isEmpty) {
      return Container(
        margin: EdgeInsets.all(25),
        child: Center(
          child: Text(
            'No Events',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w300,
              color: Provider.of<ThemeModel>(context)
                  .theme
                  .PRIMARY_TEXT_COLOR
                  .withOpacity(0.7),
            ),
          ),
        ),
      );
    } else {
      return Column(
        children: _events
            .map((element) =>
                EventCard(element, _onStarPress, ValueKey(element.eventid)))
            .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionTitle(title: listTitle),
          SectionUnderLine(),
          renderList(context)
        ],
      ),

      // Column(children: _events.map((element)=>EventCard(element, _onStarPress)).toList(),
      // ListView.builder(
      //   shrinkWrap: true,
      //   physics: NeverScrollableScrollPhysics(),
      //   // key: PageStorageKey(_key),
      //   itemCount: _events.length,
      //   padding: const EdgeInsets.all(8.0),
      //   itemBuilder: (BuildContext context, int index) {
      //     return EventCard(_events[index]);
      //   },
    );
  }
}
