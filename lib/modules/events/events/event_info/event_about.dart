import 'package:flutter/material.dart';
import '../event_class.dart';

class EventAbout extends StatelessWidget {
  final Event _event;

  EventAbout(this._event);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'ABOUT THE EVENT',
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
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                _event.about,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Center(
              child: Image.network(
                _event.imageLink,
                fit: BoxFit.scaleDown,
              ),
            )
          ],
        ),
      ),
    );
  }
}
