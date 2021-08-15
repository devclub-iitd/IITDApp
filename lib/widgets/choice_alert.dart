import 'package:IITDAPP/ThemeModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<bool> showChoiceAlert(
    BuildContext context, String title, String message, var onYesFunction) {
  return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:
                Provider.of<ThemeModel>(context).theme.ALERT_DIALOG,
            title: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'NO',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onYesFunction();
                },
                child: Text(
                  'YES',
                  style: TextStyle(color: Colors.white70),
                ),
              )
            ],
          );
        },
      ) ??
      false;
}
