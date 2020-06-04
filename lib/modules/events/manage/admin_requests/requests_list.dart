import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/events/manage/admin_requests/request_card.dart';

import 'request_class.dart';

class RequestList extends StatefulWidget {
  final List<Request> requests;

  RequestList(this.requests);

  @override
  State<StatefulWidget> createState() {
    return RequestListState();
  }
}

class RequestListState extends State<RequestList> {
  List<Request> requests;

  @override
  void initState() {
    super.initState();
    requests = widget.requests;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: requests.map((element) => RequestCard(element)).toList(),
    );
  }
}
