import 'package:flutter/material.dart';
import 'package:iitd_app/events/eventscomponents.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  EventComponents eventComponents = EventComponents();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Events"),),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                  child: Column(
            children: [
              eventComponents.eventslist(context)
            ],
                  ),
                ),
          )),
    );
  }
}
