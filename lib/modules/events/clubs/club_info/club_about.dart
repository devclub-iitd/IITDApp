import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/sectionTitle.dart';
import 'package:flutter/material.dart';

class ClubAbout extends StatelessWidget {
  final String _clubAbout;

  const ClubAbout(this._clubAbout);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionTitle(
              title: 'ABOUT THE CLUB',
            ),
            SectionUnderLine(),
            Text(
              _clubAbout,
              style: TextStyle(
                color:
                    Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR,
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
