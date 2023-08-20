// ignore_for_file: non_constant_identifier_names

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
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(eventsModel.eventName,style: const TextStyle(fontWeight: FontWeight.w600),),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                                image: NetworkImage(eventsModel.imageLink),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(eventsModel.venue),
                          Text(
                              "Starts - ${DateFormat('d MMM').format(eventsModel.startsAt!)} ${DateFormat('h:mm a').format(eventsModel.startsAt!)}"),
                          Text(
                              "Ends- ${DateFormat('d MMM').format(eventsModel.endsAt!)} ${DateFormat('h:mm a').format(eventsModel.endsAt!)}"),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Badge(
                          label: Text("+"),
                          backgroundColor: Colors.green,
                          child: Icon(Icons.calendar_month)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(Icons.star_outline)
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget EventDetailHeader(EventsModel eventsModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          Text(
            eventsModel.eventName,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Row(
            children: [
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  ": - ${eventsModel.eventBody!.clubName}",
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
           Row(
            children: [
              Chip(label: Text(eventsModel.venue),avatar: const Icon(Icons.location_on,),backgroundColor: Colors.black,labelStyle: const TextStyle(color: Colors.white),)
            ],
          )
        ],
      ),
    );
  }
}
