import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/events/error_alert.dart';
import 'package:IITDAPP/modules/events/loading.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../events/event_info/updates_class.dart';
import 'package:IITDAPP/modules/events/globals.dart';

class EventUpdate extends StatelessWidget {
  final Update _update;
  final Function onDelete;
  final String eventid;

  EventUpdate(this._update, this.onDelete, this.eventid, Key key)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      padding: EdgeInsets.only(top: 15, left: 25, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0x22AAAAAA)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  _update.message,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white70,
                ),
                onSelected: (a) => _showAlert(context),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: '',
                    child: Text('Delete Update'),
                  )
                ],
              )
              // IconButton(
              //   icon: Icon(Icons.delete, color: Colors.white,),
              //   onPressed: () {
              //     // _showAlert(context, onDelete, _update);
              //   },
              // )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                DateFormat('d MMM').format(_update.dateTime),
                style: TextStyle(fontSize: 10, color: Colors.white54),
              ),
              Text(
                ' • ',
                style: TextStyle(color: Colors.white54),
              ),
              Text(
                DateFormat('h:mm a').format(_update.dateTime),
                style: TextStyle(fontSize: 10, color: Colors.white54),
              ),
              Container(
                width: 25,
              )
            ],
          )
        ],
      ),
    );
  }

  Future deleteUpdate(BuildContext context) async {
    print("Deleting update");
    showLoading(context, message: "Deleting Update");
    // final response = await http.delete("$url/api/events/$eventid/removeUpdate", headers: {"authorization":"Bearer $token"}, body: {"updateId" : _update.id});
    var response;
    final client = http.Client();
    try {
      var rq = http.Request(
          "DELETE", Uri.parse("$url/api/events/$eventid/removeUpdate"))
        ..headers["authorization"] = "Bearer $token";
      rq.bodyFields = {"updateId": _update.id};
      response = await client.send(rq).then(http.Response.fromStream);
    } finally {
      client.close();
    }
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pop(context);
      onDelete();
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
      showErrorAlert(context, "Could not delete",
          "Something went wrong. Please try again.");
    }
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.indigo,
          title: Text(
            'Delete Update',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Are you sure you want to delete this update?',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'CANCEL',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            FlatButton(
              onPressed: () async {
                await deleteUpdate(context);
              },
              child: Text(
                'YES',
                style: TextStyle(color: Colors.white70),
              ),
            )
          ],
        );
      },
    );
  }
}
