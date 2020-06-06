import 'package:flutter/material.dart';

Future<bool> showErrorAlert(BuildContext context, String title, String message, {String command = 'OK'}) {
  return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.indigo[600],
            title: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  command,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          );
        },
      ) ??
      false;
}