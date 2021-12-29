// ignore_for_file: camel_case_types

import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/courses/screens/about.dart';
import 'package:IITDAPP/modules/courses/data/coursedata.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:IITDAPP/widgets/course_class.dart';

class Search extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(
            Icons.clear,
            color: Provider.of<ThemeModel>(context).theme.LOGIN_BUTTON_COLOR,
          )),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Provider.of<ThemeModel>(context).theme.LOGIN_BUTTON_COLOR,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // allcourses.shuffle();
    final suggestion = query.isEmpty
        ? allcourses
        : allcourses
            .where((element) =>
                element.name.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () => Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 200),
                transitionsBuilder: (BuildContext context,
                    Animation<double> first,
                    Animation<double> second,
                    Widget child) {
                  return FadeTransition(
                    opacity: first,
                    child: child,
                  );
                },
                pageBuilder: (BuildContext context, Animation<double> first,
                    Animation<double> second) {
                  return about(suggestion[index]);
                })),
        minLeadingWidth: 50,
        trailing: addremove(suggestion[index]),
        leading: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Icon(
              suggestion[index].icondata,
              color: suggestion[index].color,
            )),
        title: RichText(
          text: TextSpan(
              text: suggestion[index].name.substring(0, query.length),
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  /*color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR*/
                  color: suggestion[index].color),
              children: [
                TextSpan(
                    text: suggestion[index].name.substring(query.length),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
              ]),
        ),
      ),
      itemCount: suggestion.length,
    );
  }
}

class addremove extends StatefulWidget {
  final Course _cours;
  const addremove(this._cours);
  @override
  _addremoveState createState() => _addremoveState();
}

class _addremoveState extends State<addremove> {
  @override
  void initState() {
    IconButton(
        onPressed: () async {
          setState(() {
            if (currentUser.courses == null) {
            } else if (currentUser.courses.contains(widget._cours)) {
              currentUser.courses.remove(widget._cours);
            } else {
              currentUser.courses.insert(0, widget._cours);
            }
            callbackend();
          });
        },
        icon: currentUser.courses != null &&
                currentUser.courses.contains(widget._cours)
            ? Icon(
                Icons.remove_circle_outline_sharp,
                color: Colors.red,
              )
            : Icon(
                Icons.add_circle_outline_sharp,
                color: Colors.green,
              ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bad = AlertDialog(
      content: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        height: 40,
        child: Text(
          '${widget._cours.toString().toUpperCase()} was removed from your courses.',
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.w300, fontSize: 18),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.maybePop(context), child: Text('Okay'))
      ],
      elevation: 10,
    );
    var good = AlertDialog(
      content: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        height: 40,
        child: Text(
          '${widget._cours.name.toString().toUpperCase()} was added to your courses.',
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.w300, fontSize: 18),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.maybePop(context), child: Text('Okay'))
      ],
      elevation: 10,
    );
    return IconButton(
        onPressed: () async {
          setState(() {
            if (currentUser.courses == null) {
            } else if (currentUser.courses.contains(widget._cours)) {
              currentUser.courses.remove(widget._cours);
              showDialog(context: context, builder: (_) => bad);
            } else {
              currentUser.courses.insert(0, widget._cours);
              showDialog(context: context, builder: (_) => good);
            }
          });
          callbackend();
        },
        icon: currentUser.courses != null &&
                currentUser.courses.contains(widget._cours)
            ? Icon(
                Icons.remove_circle_outline_sharp,
                color: Colors.red,
              )
            : Icon(
                Icons.add_circle_outline_sharp,
                color: Colors.green,
              ));
  }

  void callbackend() {
    return;
  }
}
