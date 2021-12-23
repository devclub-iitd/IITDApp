// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/courses/widgets/heading.dart';
import 'package:IITDAPP/modules/courses/widgets/icons.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/courses/widgets/listcard.dart';

class about extends StatelessWidget {
  final String _course;
  const about(this._course);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: CustomAppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: DeptWise.pageIcon(_course, 30)),
          Text(_course.toUpperCase())
        ]),
        withMenu: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Heading('Books', 30),
            Divider(
              height: 0,
              thickness: 4,
              color: Colors.cyan,
              indent: 30,
              endIndent: 220,
            ),
            ListCard('Books', _course),
            Heading('Previous Year Papers', 30),
            Divider(
              height: 0,
              thickness: 4,
              color: Colors.cyan,
              indent: 30,
              endIndent: 220,
            ),
            ListCard('Minor 1', _course),
            ListCard('Minor 2', _course),
            ListCard('Major', _course),
            Container(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
