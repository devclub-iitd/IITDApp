import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ThemeModel.dart';

Future showLoading(BuildContext context, {String message = 'Please Wait'}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Provider.of<ThemeModel>(context).theme.ALERT_DIALOG,
          content: Row(children: <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            Expanded(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            )
          ]),
        ),
      );
    },
  );
}
