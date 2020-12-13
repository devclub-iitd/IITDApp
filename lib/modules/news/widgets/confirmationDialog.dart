import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showAlertDialog(
    {@required BuildContext context,
    @required NewsModel news,
    @required String actionName,
    @required Function action,
    @required String content}) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text('Cancel',
        style: TextStyle(
            color: Provider.of<ThemeModel>(context, listen: false)
                .theme
                .ALERT_DIALOG_TEXT)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget actioButton = FlatButton(
    child: Text(actionName,
        style: TextStyle(
            color: Provider.of<ThemeModel>(context, listen: false)
                .theme
                .ALERT_DIALOG_TEXT)),
    onPressed: () {
      Navigator.of(context).pop();
      action();
    },
  );
  // set up the AlertDialog
  var alert = AlertDialog(
    backgroundColor:
        Provider.of<ThemeModel>(context, listen: false).theme.ALERT_DIALOG,
    title: Text(
      actionName,
      style: TextStyle(
          color: Provider.of<ThemeModel>(context, listen: false)
              .theme
              .ALERT_DIALOG_TEXT),
    ),
    content: Text(content,
        style: TextStyle(
            color: Provider.of<ThemeModel>(context, listen: false)
                .theme
                .ALERT_DIALOG_TEXT)),
    actions: [
      cancelButton,
      actioButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
