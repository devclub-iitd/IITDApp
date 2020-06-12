import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventTime extends StatelessWidget {
  final DateTime _startsAt;
  final DateTime _endsAt;

  EventTime(this._startsAt, this._endsAt);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text('STARTS',
                  style: TextStyle(color: Colors.white70, fontSize: 9)),
              Text(DateFormat('d MMM').format(_startsAt),
                  style: TextStyle(color: Colors.white, fontSize: 13)),
              Text(DateFormat('h:mm a').format(_startsAt),
                  style: TextStyle(color: Colors.white, fontSize: 13)),
            ],
          ),
          Container(
              width: 0.5,
              height: 45,
              margin: EdgeInsets.symmetric(horizontal: 5),
              color: Colors.white),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('ENDS',
                  style: TextStyle(color: Colors.white70, fontSize: 9)),
              Text(DateFormat('d MMM').format(_endsAt),
                  style: TextStyle(color: Colors.white, fontSize: 13)),
              Text(DateFormat('h:mm a').format(_endsAt),
                  style: TextStyle(color: Colors.white, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}
