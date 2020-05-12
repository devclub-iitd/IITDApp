import 'package:flutter/material.dart';

import 'package:IITDAPP/values/colors/colors.dart';

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
    final _bg = _invert ? AppColors.CARD_LIGHT : AppColors.CARD_DARK;
    final _textColor = _invert ? AppColors.CARD_DARK : AppColors.CARD_LIGHT;
    final _subColor =
        _invert ? AppColors.CARD_SUB_DARK : AppColors.CARD_SUB_LIGHT;
    final _cardSide = 0.3 * MediaQuery.of(context).size.width;
    // print('built days card');
    return Container(
      width: _cardSide,
      height: _cardSide,
      child: Card(
        elevation: 6,
        color: _bg,
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
