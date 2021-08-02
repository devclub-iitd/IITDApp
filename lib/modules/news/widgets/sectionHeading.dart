import 'package:IITDAPP/widgets/sectionTitle.dart';
import 'package:flutter/material.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  title: text.toUpperCase(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: SectionUnderLine(),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Provider.of<ThemeModel>(context)
                  .theme
                  .RAISED_BUTTON_BACKGROUND,
            ),
            onPressed: onTap,
            child: Text('More',
                style: TextStyle(
                    color: Provider.of<ThemeModel>(context)
                        .theme
                        .RAISED_BUTTON_FOREGROUND)),
          )
        ],
      ),
    );
  }
}
