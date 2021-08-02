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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Error: $error',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context).textTheme.headline1.color, fontSize: 20),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: TextButton(
            onPressed: () {
              refresh();
            },
            style: TextButton.styleFrom(
                primary: Provider.of<ThemeModel>(context)
                    .theme
                    .RAISED_BUTTON_FOREGROUND,
                backgroundColor: Provider.of<ThemeModel>(context)
                    .theme
                    .RAISED_BUTTON_BACKGROUND),
            child: Text('REFRESH'),
          ),
        )
      ],
    );
  }
}
