import 'package:flutter/material.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';

class CoursePageHeader extends StatelessWidget {
  final String _name, _abbr;
  const CoursePageHeader(
    this._name,
    this._abbr, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 1080,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Hero(
              tag: _abbr,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  _name,
                  style: Theme.of(context).primaryTextTheme.headline4.apply(
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .PRIMARY_TEXT_COLOR,
                        fontSizeFactor: 0.8,
                        decoration: null,
                      ),
                ),
              ),
            ),
          ),
          Text(
            _abbr,
            style: Theme.of(context).primaryTextTheme.bodyText2.apply(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR
                      .withOpacity(0.3),
                  fontSizeFactor: 1,
                  decoration: null,
                ),
          ),
        ],
      ),
    );
  }
}
