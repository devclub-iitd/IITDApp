import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/dashboard/data/tabDataProvider.dart';
import 'package:IITDAPP/utility/apiResponse.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabHead<T> extends StatelessWidget {
  const TabHead({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Consumer<TabDataProvider<T>>(
        builder: (_, tdp, c) => buildTab(
            title,
            (tdp.data.status != Status.COMPLETED) ? 0 : tdp.alerts.length,
            Provider.of<ThemeModel>(context).theme.PRIMARY_TEXT_COLOR));
  }
}

Widget buildTab(String title, int alerts, Color titleColor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      AutoSizeText(
        title,
        style: TextStyle(
          fontSize: 14,
          color: titleColor,
        ),
      ),
      if (alerts > 0)
        CircleAvatar(
          radius: 10,
          backgroundColor: Colors.red,
          child: Text(alerts.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12)),
        )
    ],
  );
}
