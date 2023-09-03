import 'package:flutter/material.dart';
import 'package:iitd_app/features/events/components/eventscomponents.dart';
import 'package:iitd_app/models/eventsmodel.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class EventDetails extends StatefulWidget {
  final EventsModel eventsModel;
  const EventDetails({super.key, required this.eventsModel});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: BoldText(
          title: widget.eventsModel.eventName,
          size: 24,
          textcolor: AppColors.backgroundColor,
        ),
        backgroundColor: AppColors.primaryColorDark,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventDetailHeader(
                eventsModel: widget.eventsModel,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    backgroundColor:
                        AppColors.primaryColorLight.withOpacity(0.2),
                    label: Text(
                        "${DateFormat('d MMM').format(widget.eventsModel.startsAt!)} ${DateFormat('h:mm a').format(widget.eventsModel.startsAt!)}"),
                    avatar: const Icon(
                      Icons.timer,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  Chip(
                    backgroundColor:
                        AppColors.primaryColorLight.withOpacity(0.2),
                    label: Text(
                        "${DateFormat('d MMM').format(widget.eventsModel.endsAt!)} ${DateFormat('h:mm a').format(widget.eventsModel.endsAt!)}"),
                    avatar: const Icon(
                      Icons.timer_off,
                      color: AppColors.secondaryColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const BoldText(
                  title: "Event Description",
                  size: 18,
                  textcolor: AppColors.textColor),
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 100,
                height: 3,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1.5)),
                    color: AppColors.greenShadeColor),
              ),
              const SizedBox(
                height: 10,
              ),
              LinkText(text: widget.eventsModel.about),
              const SizedBox(
                height: 15,
              ),
              Image.network(
                widget.eventsModel.imageLink!,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
