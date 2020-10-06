import 'package:flutter/material.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';

class DaysCard extends StatelessWidget {
  final int _number;
  final String _word;
  final bool _invert;
  const DaysCard(
    this._number,
    this._word,
    this._invert, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bg = _invert
        ? Provider.of<ThemeModel>(context).theme.CARD_LIGHT
        : Provider.of<ThemeModel>(context).theme.CARD_DARK;
    final _textColor = _invert
        ? Provider.of<ThemeModel>(context).theme.CARD_DARK
        : Provider.of<ThemeModel>(context).theme.CARD_LIGHT;
    final _subColor = _invert
        ? Provider.of<ThemeModel>(context).theme.CARD_DARK.withOpacity(0.5)
        : Provider.of<ThemeModel>(context).theme.CARD_LIGHT.withOpacity(0.5);
    final _cardSide = 0.3 * MediaQuery.of(context).size.width;
    // print('built days card');
    return Container(
      width: _cardSide,
      height: _cardSide,
      child: Container(
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(0.01),
                Colors.black.withOpacity(0.1)
              ]),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _bg.withOpacity(1.0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(1, 3),
                  blurRadius: 4,
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .CARD_DARK
                      .withOpacity(0.5))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('$_number',
                style: Theme.of(context).primaryTextTheme.headline2.apply(
                    color: _textColor, decoration: null, fontWeightDelta: 2)),
            Text('$_word',
                style: Theme.of(context).primaryTextTheme.bodyText2.apply(
                    color: _subColor, fontSizeFactor: 1, decoration: null)),
          ],
        ),
      ),
    );
  }
}
