import 'package:flutter/material.dart';
import 'package:iitd_app/events/eventscomponents.dart';
import 'package:iitd_app/models/eventsmodel.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatefulWidget {
  EventsModel eventsModel;
  EventDetails({super.key, required this.eventsModel});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Event"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventComponents().EventDetailHeader(widget.eventsModel, context),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(DateFormat('d MMM')
                            .format(widget.eventsModel.startsAt!) +
                        " " +
                        DateFormat('h:mm a')
                            .format(widget.eventsModel.startsAt!)),
                    avatar: const Icon(Icons.timer),
                  ),
                  Chip(
                    label: Text(
                        DateFormat('d MMM').format(widget.eventsModel.endsAt!) +
                            " " +
                            DateFormat('h:mm a')
                                .format(widget.eventsModel.endsAt!)),
                    avatar: const Icon(Icons.timer_off),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ABOUT THE EVENT",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Colors.white),
                  ),
                  Badge(
                      label: Text("+"),
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                        size: 30,
                      )),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 60,
                height: 3,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1.5)),
                    color: Colors.green),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.eventsModel.about,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.eventsModel.imageLink,
                        ),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "UPDATES",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: Colors.white),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 60,
                height: 3,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1.5)),
                    color: Colors.green),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
