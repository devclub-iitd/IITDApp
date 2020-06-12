import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:IITDAPP/widgets/error_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:IITDAPP/modules/events/events/event_info/updates_class.dart';
import 'package:pedantic/pedantic.dart';

class AddUpdate extends StatefulWidget {
  final Function _onSubmit;
  final String eventid;

  AddUpdate(this._onSubmit, this.eventid);

  @override
  State<StatefulWidget> createState() {
    return _AddUpdateState();
  }
}

class _AddUpdateState extends State<AddUpdate> {
  bool enabled;
  Function _onSubmit;
  String eventid;
  String hint;

  @override
  void initState() {
    super.initState();
    hint = 'Add an update...';
    enabled = true;
    eventid = widget.eventid;
    _onSubmit = widget._onSubmit;
  }

  Future<Null> addUpdateRequest(String eventid, Update update) async {
    print('adding event');
    enabled = false;
    hint = 'Adding Update. Please Wait...';
    setState(() {});
    final response = await http.post('$url/api/events/$eventid/addUpdate',
        headers: {'authorization': 'Bearer $token'}, body: update.toMap());
    enabled = true;
    hint = 'Add an update...';
    setState(() {});
    print(response.statusCode);
    if(response.statusCode == 200){
    _onSubmit();}
    else {
      await showErrorAlert(context, 'Could not add', 'Something went wrong. Please try again');
    }
    return null;
  }

  final TextEditingController _controller = TextEditingController();
  String _message;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 7),
            child: TextField(
              decoration: InputDecoration(
                  enabled: enabled,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  filled: true,
                  fillColor: Color(0x0AAAAAAA),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white54)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.white54)),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(color: Colors.white),
              controller: _controller,
              onChanged: (text) {
                _message = text;
              },
              // onSubmitted: (text) {
              //   _controller.clear();
              //   _onSubmit(text);
              //   FocusScope.of(context).requestFocus(FocusNode());
              // },
            ),
          ),
          FlatButton(
            onPressed: () async {
              if (_message == null || _message.isEmpty) {
                return null;
              }
              var upd = Update(
                message: _message,
                title: 'TITLE',
              );
              unawaited(addUpdateRequest(eventid, upd));
              _controller.clear();
              _message = '';
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Text(
              'SUBMIT',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.indigo[400],
          )
        ],
      ),
    );
  }
}
