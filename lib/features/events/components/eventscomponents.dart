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

class EventComponents {
  Widget eventslist(BuildContext context) {
    return Consumer<EventState>(builder: (_, eventState, child) {
      if (eventState.eventsListStatus == EventsListStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        );
      } else {
        return ListView.builder(
            itemCount: eventState.eventsList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              EventsModel eventsModel = eventState.eventsList[i];
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
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NormalText500(
                        title: eventsModel.eventName,
                        textcolor: AppColors.primaryColor,
                        size: 16,
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
                                    const BorderRadius.all(Radius.circular(5)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  NormalText400(
                                    title: eventsModel.venue,
                                    textcolor: AppColors.textColor,
                                    size: 13,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    color: AppColors.secondaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  NormalText400(
                                    title:
                                        "Starts - ${DateFormat('d MMM').format(eventsModel.startsAt!)} ${DateFormat('h:mm a').format(eventsModel.startsAt!)}",
                                    textcolor: AppColors.textColor,
                                    size: 13,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.timer_off,
                                    color: AppColors.secondaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
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
                image: NetworkImage(eventsModel.imageLink), fit: BoxFit.cover),
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
