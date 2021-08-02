import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/sectionTitle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../events/event_info/updates_class.dart';
import './update.dart';
import './add_update.dart';

class EventUpdatesList extends StatefulWidget {
  final String eventid;

  EventUpdatesList(this.eventid);

  @override
  State<StatefulWidget> createState() {
    return _EventUpdateList();
  }
}

class _EventUpdateList extends State<EventUpdatesList> {
  // List<Update> _updates;
  String id;
  Future<List<Update>> _updates;

  @override
  void initState() {
    super.initState();
    id = widget.eventid;
    _updates = getUpdates(id);
  }

  Future<List<Update>> getUpdates(String eventid) async {
    print('getting updates');
    final response = await http.get('$url/api/events/$eventid',
        headers: {'authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var parsedJson = json.decode(response.body);
      // ignore: prefer_collection_literals
      var updateList = [];
      for (var i = 0; i < parsedJson['event']['updates'].length; i++) {
        var update = Update.fromJson(parsedJson['event']['updates'][i]);
        updateList.add(update);
      }
      // _updates = updateList;
      return updateList;
    } else {
      throw Exception('Failed');
    }
  }

  void _reload() {
    _updates = getUpdates(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionTitle(
            title: 'UPDATES',
          ),
          SectionUnderLine(),
          FutureBuilder(
            future: _updates,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                List<Update> upd = snapshot.data;
                if (upd.isEmpty) {
                  return Container(
                    margin: EdgeInsets.all(25),
                    child: Center(
                      child: Text(
                        'No Updates',
                        style: TextStyle(
                            color: Provider.of<ThemeModel>(context)
                                .theme
                                .PRIMARY_TEXT_COLOR
                                .withOpacity(0.7)),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: upd
                        .map((element) => EventUpdate(
                            element, _reload, id, ValueKey(element.id)))
                        .toList(),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Some Error Occured',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                );
              }

              return Container(
                margin: EdgeInsets.all(20),
                child: Center(
                  child: CircularProgressIndicator(
                      // valueColor: AlwaysStoppedAnimation<Color>(
                      //     Provider.of<ThemeModel>(context,listen:false).theme.PRIMARY_TEXT_COLOR),
                      ),
                ),
              );
            },
          ),
          AddUpdate(_reload, id),
        ],
      ),
    );
  }
}
