import 'package:IITDAPP/values/Constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'request_class.dart';

class RequestCard extends StatelessWidget {
  final Request request;

  const RequestCard(this.request);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0x22AAAAAA),
      ),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(request.name),
              Text(request.email),
              Text('for'),
              Text(request.clubName),
            ],
          ),
          ResponseIcons(),
        ],
      ),
    );
  }
}

class ResponseIcons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ResponseIconsState();
  }
}

class ResponseIconsState extends State<ResponseIcons> {
  String state;

  @override
  void initState() {
    super.initState();
    state = 'pending';
  }

  Future<void> reqeustResponse(String ans) async {
    final response = await http.post('$uri/api',
        headers: {'authorization': 'Bearer $token'}, body: {'response': ans});

    if (response.statusCode == 200) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
            onPressed: () {
              state = 'accepted';
              setState(() {});
              // reqeustResponse(state);
            },
            icon: (state == 'accepted')
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : Icon(Icons.check_circle_outline)),
        IconButton(
            onPressed: () {
              state = 'rejected';
              setState(() {});
              // reqeustResponse(state);
            },
            icon: (state == 'rejected')
                ? Icon(
                    Icons.cancel,
                    color: Colors.red,
                  )
                : Icon(Icons.highlight_off)),
      ],
    );
  }
}
