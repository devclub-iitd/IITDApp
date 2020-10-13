import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
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
                  style: TextStyle(
                      color: Provider.of<ThemeModel>(context)
                          .theme
                          .PRIMARY_TEXT_COLOR
                          .withOpacity(0.7),
                      fontSize: 9)),
              Text(DateFormat('d MMM').format(_startsAt),
                  style: TextStyle(fontSize: 13)),
              Text(DateFormat('h:mm a').format(_startsAt),
                  style: TextStyle(fontSize: 13)),
            ],
          ),
          Container(
            width: 0.5,
            height: 45,
            margin: EdgeInsets.symmetric(horizontal: 5),
            color: Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('ENDS',
                  style: TextStyle(
                      color: Provider.of<ThemeModel>(context)
                          .theme
                          .PRIMARY_TEXT_COLOR
                          .withOpacity(0.7),
                      fontSize: 9)),
              Text(DateFormat('d MMM').format(_endsAt),
                  style: TextStyle(fontSize: 13)),
              Text(DateFormat('h:mm a').format(_endsAt),
                  style: TextStyle(fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}
