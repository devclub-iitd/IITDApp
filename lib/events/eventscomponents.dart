import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iitd_app/dummydata.dart';
import 'package:iitd_app/events/event_details.dart';
import 'package:intl/intl.dart';
import '../models/eventsmodel.dart';

class EventComponents {
  Widget eventslist(BuildContext context) {
    return ListView.builder(
        itemCount: dummyeventsList().length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          EventsModel eventsModel = dummyeventsList()[i];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventDetails(
                          eventsModel: eventsModel,
                        )),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Color.fromARGB(115, 74, 74, 74),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventsModel.eventName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                                image: NetworkImage(eventsModel.imageLink),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                eventsModel.venue,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.timer,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Starts - ${DateFormat('d MMM').format(eventsModel.startsAt!)} ${DateFormat('h:mm a').format(eventsModel.startsAt!)}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.timer_off,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Ends- ${DateFormat('d MMM').format(eventsModel.endsAt!)} ${DateFormat('h:mm a').format(eventsModel.endsAt!)}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Chip(
                        label: Text("Add to calender"),
                        avatar: Badge(
                            label: Text("+"),
                            backgroundColor: Colors.green,
                            child: Icon(Icons.calendar_month)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Chip(
                        avatar: InkWell(child: Icon(Icons.star_outline)),
                        label: Text("star"),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget EventDetailHeader(EventsModel eventsModel, BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Stack(children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(eventsModel.imageLink), fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2,
              sigmaY: 2,
            ),
            child: Container(
              decoration: BoxDecoration(color: Colors.black45),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(child: Container()),
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      DateFormat('d MMM')
                          .format(eventsModel.endsAt!)
                          .split(" ")[0],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                          color: Colors.red),
                    ),
                    Text(
                      DateFormat('d MMM')
                          .format(eventsModel.endsAt!)
                          .split(" ")[1],
                      style: const TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${eventsModel.eventBody!.clubName} ",
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                eventsModel.eventName,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
