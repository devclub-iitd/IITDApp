import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iitd_app/core/appstate.dart';
import 'package:iitd_app/features/events/pages/event_details.dart';
import 'package:iitd_app/models/eventsmodel.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/constants.dart';
import 'package:iitd_app/utils/globalwidgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

var textInputdec = const InputDecoration(
    labelStyle: TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
    errorBorder: OutlineInputBorder(borderSide: BorderSide.none));

class EventsList extends StatefulWidget {
  const EventsList(
      {super.key, required this.clubID, required this.tabSelected});

  final int tabSelected;
  final String clubID;

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<EventState>(context, listen: false)
          .fetchEvents(widget.clubID);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<EventsModel> upcomingEvents(List<EventsModel> inputList) {
      DateTime currentDate = DateTime.now();
      List<EventsModel> filteredList = [];

      for (EventsModel event in inputList) {
        DateTime endsat = event.endsAt!;
        if (endsat.isAfter(currentDate)) {
          filteredList.add(event);
        }
      }
      return filteredList;
    }

    List<EventsModel> pastEvents(List<EventsModel> inputList) {
      DateTime currentDate = DateTime.now();
      List<EventsModel> filteredList = [];

      for (EventsModel event in inputList) {
        DateTime endsat = event.endsAt!;
        if (endsat.isBefore(currentDate)) {
          filteredList.add(event);
        }
      }
      return filteredList;
    }

    return Consumer<EventState>(builder: (_, eventState, child) {
      if (eventState.eventsListStatus == EventsListStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        );
      } else {
        List<EventsModel> eventstbDisplay = [];

        if (widget.tabSelected == 0) {
          eventstbDisplay = upcomingEvents(eventState.eventsList);
        } else if (widget.tabSelected == 1) {
          eventstbDisplay = pastEvents(eventState.eventsList);
        } else {
          eventstbDisplay = eventState.eventsList;
        }

        return eventstbDisplay.isEmpty
            ? const EmptyContainer(emptytext: "Sorry, there are no events")
            : ListView.builder(
                itemCount: eventstbDisplay.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  EventsModel eventsModel = eventstbDisplay[i];
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
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColorLight.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText500(
                            title: eventsModel.eventName,
                            textcolor: AppColors.primaryColor,
                            size: 16,
                          ),
                          BoldText(
                              title: eventsModel.eventBody!.clubName,
                              size: 12,
                              textcolor: AppColors.textColor),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 75,
                                  width: 75,
                                  child: Image.network(
                                    eventsModel.imageLink!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  NormalText400(
                                    title: eventsModel.venue,
                                    textcolor: AppColors.textColor,
                                    size: 13,
                                  ),
                                  NormalText400(
                                    title:
                                        "Starts - ${DateFormat('d MMM').format(eventsModel.startsAt!)} ${DateFormat('h:mm a').format(eventsModel.startsAt!)}",
                                    textcolor: AppColors.textColor,
                                    size: 13,
                                  ),
                                  NormalText400(
                                    title:
                                        "Ends - ${DateFormat('d MMM').format(eventsModel.endsAt!)} ${DateFormat('h:mm a').format(eventsModel.endsAt!)}",
                                    textcolor: AppColors.textColor,
                                    size: 13,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: AppColors.secondaryColor,
                                ),
                                child: const NormalText400(
                                  title: "Add to Calendar",
                                  textcolor: AppColors.backgroundColor,
                                  size: 13,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const InkWell(child: Icon(Icons.star_outline))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
      }
    });
  }
}

class EventDetailHeader extends StatelessWidget {
  const EventDetailHeader({super.key, required this.eventsModel});
  final EventsModel eventsModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Stack(children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(eventsModel.imageLink!), fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2,
              sigmaY: 2,
            ),
            child: Container(
              decoration: const BoxDecoration(color: Colors.black45),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(child: Container()),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('d MMM')
                          .format(eventsModel.endsAt!)
                          .split(" ")[0],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
