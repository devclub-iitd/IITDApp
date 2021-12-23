import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class EventVenue extends StatelessWidget {
  final String _venue;

  const EventVenue(this._venue);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Text('AT',
              style: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR
                      .withOpacity(0.7),
                  fontSize: 9)),
          Text(
            _venue,
            style: TextStyle(
              color: Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
