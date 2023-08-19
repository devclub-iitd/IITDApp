import 'package:flutter/material.dart';
import 'package:iitd_app/events/eventscomponents.dart';
import 'package:iitd_app/models/eventsmodel.dart';

class EventDetails extends StatefulWidget {
  EventsModel eventsModel;
   EventDetails({super.key,required this.eventsModel});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Event"),),
      body: SafeArea(child: Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            EventComponents().EventDetailHeader(widget.eventsModel),
            SizedBox(height: 20,),
            
          ],
        ),
      )),
    );
  }
}
