import 'package:IITDAPP/widgets/cancel_alert.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import './add_event_form.dart';
// import '../events/event_class.dart';

class AddEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showCancelAlert(context, 'Cancel making new event?', 'Are you sure you want to discard the new event?'),
      child: Scaffold(
        appBar: GradientAppBar(
          title: Text('Create Event'),
          centerTitle: true,
          backgroundColorStart: Colors.indigo,
          backgroundColorEnd: Colors.cyan,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          behavior: HitTestBehavior.opaque,
          child: ListView(
            children: <Widget>[EventForm()],
          ),
        ),
      ),
    );
  }
}
