import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/sectionTitle.dart';
import 'package:flutter/material.dart';
import '../event_class.dart';

class EventAbout extends StatelessWidget {
  final Event _event;

  const EventAbout(this._event);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionTitle(
              title: 'ABOUT THE EVENT',
            ),
            SectionUnderLine(),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                _event.about,
                style: TextStyle(
                  color:
                      Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR,
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Center(child: Image.network(_event.imageLink)),
          ],
        ),
      ),
    );
  }
}
