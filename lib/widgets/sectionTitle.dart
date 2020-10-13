import 'package:IITDAPP/ThemeModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR,
          fontWeight: FontWeight.w900,
          fontSize: 15,
          letterSpacing: 4),
    );
  }
}

class SectionUnderLine extends StatelessWidget {
  const SectionUnderLine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: 60,
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Provider.of<ThemeModel>(context).theme.TITLE_UNDERLINE,
    );
  }
}
