import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'package:IITDAPP/modules/events/globals.dart';

import '../club_class.dart';

class ClubInfoCard extends StatelessWidget {
  final Club _club;

  ClubInfoCard(this._club);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: AutoSizeText(
              _club.clubName,
              style: TextStyle(fontSize: 30, color: Colors.white),
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
    if (_club.isSubbed) {
      _text = 'SUBSCRIBED';
      _textColor = Colors.white54;
      _buttonColor = Colors.indigo[400];
    } else {
      _text = 'SUBSCRIBE';
      _textColor = Colors.white;
      _buttonColor = Color(0xFF7C8EEF);
    }
  }

  Future onButtonPress() async {
    print('Subbing to Club');
    _enabled = false;
    setState(() {});
    final response = await http.post('$url/api/body/${_club.id}/subscribe',
        headers: {'authorization': 'Bearer $token'});
    print(response.statusCode);
    if (response.statusCode == 200) {
      _club.isSubbed = !_club.isSubbed;
      if (_club.isSubbed) {
        subbedClubs.add(_club);
        otherClubs.remove(_club);
        _text = 'SUBSCRIBED';
        _textColor = Colors.white54;
        _buttonColor = Colors.indigo[400];
      } else {
        subbedClubs.remove(_club);
        otherClubs.add(_club);
        _text = 'SUBSCRIBE';
        _textColor = Colors.white;
        _buttonColor = Color(0xFF7C8EEF);
      }
    }
    _enabled = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (_enabled)
          ? () {
              onButtonPress();
            }
          : null,
      color: _buttonColor,
      textColor: _textColor,
      child: Text(_text),
      disabledColor: Colors.grey.withOpacity(0.5),
    );
  }
}
