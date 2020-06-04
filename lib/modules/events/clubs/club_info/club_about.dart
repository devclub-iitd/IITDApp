import 'package:flutter/material.dart';

class ClubAbout extends StatelessWidget {
  final String _clubAbout;

  ClubAbout(this._clubAbout);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'ABOUT THE CLUB',
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
            Text(
              _clubAbout,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
