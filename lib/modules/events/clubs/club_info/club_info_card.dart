import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
// import 'package:IITDAPP/modules/events/globals.dart';

import '../club_class.dart';

class ClubInfoCard extends StatelessWidget {
  final Club _club;

  ClubInfoCard(this._club);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:
              Provider.of<ThemeModel>(context).theme.DEFAULT_WIDGET_BACKGROUND,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 2),
                spreadRadius: 1,
                blurRadius: 2,
                color: Provider.of<ThemeModel>(context)
                    .theme
                    .PRIMARY_TEXT_COLOR
                    .withOpacity(0.1))
          ]),
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: AutoSizeText(
              _club.clubName,
              style: TextStyle(
                  fontSize: 30,
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          SubButton(_club),
        ],
      ),
    );
  }
}

class SubButton extends StatefulWidget {
  final Club _club;

  SubButton(this._club);

  @override
  State<StatefulWidget> createState() {
    return _SubButtonState();
  }
}

class _SubButtonState extends State<SubButton> {
  Club _club;
  String _text;
  Color _textColor;
  Color _buttonColor;
  bool _enabled;

  @override
  void initState() {
    super.initState();
    _club = widget._club;
    _enabled = true;
  }

  Future onButtonPress() async {
    print('Subbing to Club');
    _enabled = false;
    var timeOutFlag = false;
    setState(() {});
    final response = await http.post('$uri/api/body/${_club.id}/subscribe',
        headers: {
          'authorization': 'Bearer $token'
        }).timeout(Duration(seconds: 5), onTimeout: () {
      timeOutFlag = true;
      return null;
    });
    if (timeOutFlag) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Cannot Connect to Server!')));
      return;
    }
    print(response.statusCode);
    if (response.statusCode == 200) {
      var workingClub = Provider.of<EventsTabProvider>(context, listen: false)
          .allClubs
          .firstWhere((element) => element.id == _club.id);
      Provider.of<EventsTabProvider>(context, listen: false)
          .toggleClubSubscribe(_club.id);
      _club.isSubbed = workingClub.isSubbed;
      // _club.isSubbed = !_club.isSubbed;
      // if (_club.isSubbed) {
      //   subbedClubs.add(_club);
      //   otherClubs.remove(_club);
      //   _text = 'SUBSCRIBED';
      //   _textColor = Provider.of<ThemeModel>(context, listen: false)
      //       .theme
      //       .RAISED_BUTTON_FOREGROUND;
      //   _buttonColor = Provider.of<ThemeModel>(context, listen: false)
      //       .theme
      //       .RAISED_BUTTON_BACKGROUND;
      // } else {
      //   subbedClubs.remove(_club);
      //   otherClubs.add(_club);
      //   _text = 'SUBSCRIBE';
      //   _textColor = Provider.of<ThemeModel>(context, listen: false)
      //       .theme
      //       .RAISED_BUTTON_ALT_FOREGROUND;
      //   _buttonColor = Provider.of<ThemeModel>(context, listen: false)
      //       .theme
      //       .RAISED_BUTTON_ALT_BACKGROUND;
      // }
    }
    _enabled = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_club.isSubbed) {
      _text = 'SUBSCRIBED';
      _textColor = Provider.of<ThemeModel>(context, listen: false)
          .theme
          .RAISED_BUTTON_ALT_FOREGROUND;
      _buttonColor = Provider.of<ThemeModel>(context, listen: false)
          .theme
          .RAISED_BUTTON_ALT_BACKGROUND;
    } else {
      _text = 'SUBSCRIBE';
      _textColor = Provider.of<ThemeModel>(context, listen: false)
          .theme
          .RAISED_BUTTON_FOREGROUND;
      _buttonColor = Provider.of<ThemeModel>(context, listen: false)
          .theme
          .RAISED_BUTTON_BACKGROUND;
    }
    return TextButton(
        onPressed: (_enabled)
            ? () {
                onButtonPress();
              }
            : null,
        style: TextButton.styleFrom(
          primary: _textColor, // foreground
          backgroundColor: _buttonColor,
        ),
        child: Text(_text));
  }
}
