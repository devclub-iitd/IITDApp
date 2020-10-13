import 'package:flutter/material.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';

class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    Key key,
    @required this.refresh,
    @required this.error,
  }) : super(key: key);

  final Function refresh;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Error: ${error}',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).textTheme.headline1.color),
        ),
        FlatButton(
          onPressed: () {
            refresh();
          },
          child: Text('REFRESH'),
          textColor:
              Provider.of<ThemeModel>(context).theme.RAISED_BUTTON_FOREGROUND,
          color:
              Provider.of<ThemeModel>(context).theme.RAISED_BUTTON_BACKGROUND,
        )
      ],
    );
  }
}
