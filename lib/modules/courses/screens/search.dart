import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/courses/screens/about.dart';
import 'package:IITDAPP/modules/courses/data/coursedata.dart';
import 'package:IITDAPP/modules/courses/widgets/icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final suggestion = query.isEmpty
        ? all
        : all
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
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
            child: DeptWise(suggestion[index], 30)),
        title: RichText(
          text: TextSpan(
              text: suggestion[index].substring(0, query.length),
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  /*color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR*/
                  color: DeptWise.getColor(suggestion[index])),
              children: [
                TextSpan(
                    text: suggestion[index].substring(query.length),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
              ]),
        ),
      ),
      itemCount: suggestion.length,
    );
  }
}

class addremove extends StatefulWidget {
  final String _cours;
  addremove(this._cours);
  @override
  _addremoveState createState() => _addremoveState();
}

class _addremoveState extends State<addremove> {
  @override
  void initState() {
    IconButton(
        onPressed: () async {
          setState(() {
            if (your.contains(widget._cours)) {
              your.remove(widget._cours);
            } else {
              your.insert(0, widget._cours);
            }
          });
          await savedstate.setstate(your);
        },
        icon: your.contains(widget._cours)
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
          '${widget._cours.toString().toUpperCase()} was added to your courses.',
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
            if (your.contains(widget._cours)) {
              your.remove(widget._cours);
              showDialog(context: context, builder: (_) => bad);
            } else {
              your.insert(0, widget._cours);
              showDialog(context: context, builder: (_) => good);
            }
          });

          await savedstate.setstate(your);
        },
        icon: your.contains(widget._cours)
            ? Icon(
                Icons.remove_circle_outline_sharp,
                color: Colors.red,
              )
            : Icon(
                Icons.add_circle_outline_sharp,
                color: Colors.green,
              ));
  }
}

class savedstate {
  static SharedPreferences _preferences;
  static const _key = 'your';
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setstate(List<String> your) async =>
      await _preferences.setStringList(_key, your);
  static List<String> getstate() => _preferences.getStringList(_key);
}
