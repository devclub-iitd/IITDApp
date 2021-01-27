import 'package:flutter/material.dart';

import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';

class EmptyScreen extends StatelessWidget {
  final String title, message, tag;

  const EmptyScreen(
      {Key key,
      @required this.title,
      @required this.message,
      @required this.tag})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: CustomAppBar(
        title: Text(title),
      ),
      drawer: AppDrawer(
        tag: tag,
      ),
      body: Center(
          child: Text(message,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300))),
    );
  }
}
