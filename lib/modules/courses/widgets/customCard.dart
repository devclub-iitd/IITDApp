// import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/courses/courses.dart';
import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';

class CustomCard extends StatefulWidget {
  const CustomCard();
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    const height = 600.0;
    return Scaffold(
        backgroundColor: Colors.transparent,
        // Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () async {},
          backgroundColor: Colors.greenAccent,
          child: IconButton(
            onPressed: () {
              print(widget.toString());
            },
            icon: FaIcon(
              FontAwesomeIcons.fileExport,
              // Icons.share,
              size: 25,
            ),
          ),
        ),
        body: Container(
          height: height, // change this
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(height / 20)),
              // color: Color.fromARGB(255, 255, 255, 255),
              color: Color.fromARGB(255, 37, 37, 37)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(height: 10),
              Text(
                'Courses',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
              ),
              Container(height: 10),
              Text(
                '2021-22',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Container(height: 8),
              Divider(
                color: Colors.grey,
              ),
              SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ...currentUser.tocalender.map((e) => UserCourse(e)).toList(),
                ],
              ))
            ],
          ),
        ));
  }
}
