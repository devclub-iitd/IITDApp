import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:IITDAPP/modules/events/manage/admin_requests/requests_list.dart';

import 'request_class.dart';

Future<List<Request>> getRequests() async {
  final response =
      await http.get('$url/api/', headers: {'authorization': 'Bearer $token'});

  if (response.statusCode == 200) {
    var parsedJson = json.decode(response.body);
    // ignore: prefer_collection_literals
    var requests = List<Request>();
    for (var i = 0; i < parsedJson[''].length; i++) {
      var r = Request.fromJson(parsedJson[''][i]);
      requests.add(r);
    }
    return requests;
  } else {
    throw Exception('Could not get requests');
  }
}

class RequestScreen extends StatelessWidget {
  final Future<List<Request>> requests = getRequests();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        backgroundColorStart: Colors.indigo,
        backgroundColorEnd: Colors.cyan,
        title: Text('Admins'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: requests,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RequestList(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Some Error Occured'),
            );
          }

          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        },
      ),
    );
  }
}
