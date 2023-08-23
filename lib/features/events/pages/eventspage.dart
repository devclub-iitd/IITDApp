import 'package:flutter/material.dart';
import 'package:iitd_app/features/drawer.dart';
import 'package:iitd_app/features/events/components/eventscomponents.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  EventComponents eventComponents = EventComponents();
  int sel = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const BoldText(
          title: "Events",
          size: 24,
          textcolor: AppColors.backgroundColor,
        ),
        backgroundColor: AppColors.primaryColorDark,
      ),
      drawer: buildDrawer(context),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: AppColors.primaryColorLight.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Column(
                  children: [
                    BoldText(
                      title: "DevClub, IIT Delhi",
                      size: 18,
                      textcolor: AppColors.secondaryColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Chip(
                      label: Text("SUBSCRIBE"),
                      backgroundColor: AppColors.greenShadeColor,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const BoldText(
                title: "Club Events",
                size: 18,
                textcolor: AppColors.secondaryColor,
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 100,
                height: 3,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1.5)),
                    color: AppColors.greenShadeColor),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sel = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: sel == 0
                              ? AppColors.primaryColorDark
                              : AppColors.primaryColorLight.withOpacity(0.2)),
                      child: Center(
                        child: Text(
                          "Upcoming",
                          style: TextStyle(
                              color: sel == 0
                                  ? AppColors.backgroundColor
                                  : AppColors.textColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      sel = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: sel == 1
                              ? AppColors.primaryColorDark
                              : AppColors.primaryColorLight.withOpacity(0.2)),
                      child: Center(
                        child: Text(
                          "Past",
                          style: TextStyle(
                              color: sel == 1
                                  ? AppColors.backgroundColor
                                  : AppColors.textColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              eventComponents.eventslist(context)
            ],
          ),
        ),
      )),
    );
  }
}
