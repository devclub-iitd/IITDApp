import 'package:flutter/material.dart';
import 'package:IITDAPP/values/colors/colors.dart';

class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    Key key, @required this.refresh,@required this.error,
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
          textColor: AppColors.PRIMARY_COLOR_DARK,
          color: AppColors.PRIMARY_COLOR,
        )
      ],
    );
  }
}
