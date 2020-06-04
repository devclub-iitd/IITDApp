import 'package:flutter/material.dart';

class EventVenue extends StatelessWidget {
  final String _venue;

  EventVenue(this._venue);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Text('AT', style: TextStyle(color: Colors.white70, fontSize: 9)),
          Text(
            _venue,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
