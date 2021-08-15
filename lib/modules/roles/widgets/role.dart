import 'package:IITDAPP/modules/courses/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/roles/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:IITDAPP/modules/roles/widgets/user.dart';
import 'package:IITDAPP/modules/roles/widgets/people.dart';

class Roles extends StatefulWidget {
  final String name;
  final String org;
  const Roles(this.name, this.org);
  @override
  _RolesState createState() => _RolesState();
}

class _RolesState extends State<Roles> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.red,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name),
              Spacer(),
              IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 100),
                          transitionsBuilder: (BuildContext context,
                              Animation<double> first,
                              Animation<double> second,
                              Widget child) {
                            return FadeTransition(
                              opacity: first,
                              child: child,
                            );
                          },
                          pageBuilder: (BuildContext context,
                              Animation<double> first,
                              Animation<double> second) {
                            return SearchScreen();
                          })),
                  icon: Icon(CupertinoIcons.person_badge_plus)),
            ],
          ),
        ),
        //all the people w that role
        for (int i = 0;
            i < data[widget.org.toLowerCase()][widget.name].length;
            i++)
          PersonCard(data[widget.org.toLowerCase()][widget.name][i]),
      ],
    );
  }
}
