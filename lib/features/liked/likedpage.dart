import 'package:flutter/material.dart';
import 'package:iitd_app/features/drawer.dart';
import 'package:iitd_app/features/events/components/eventscomponents.dart';
import 'package:iitd_app/models/eventsmodel.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/constants.dart';
import 'package:iitd_app/utils/globalwidgets.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    List<EventsModel> list = likedevents;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const BoldText(
            title: "Liked Events",
            size: 24,
            textcolor: AppColors.backgroundColor,
          ),
          backgroundColor: AppColors.primaryColorDark,
        ),
        drawer: buildDrawer(context),
        body: list.isEmpty
            ? const EmptyContainer(emptytext: "There are no liked events")
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: list.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        EventsModel eventsModel = list[i];
                        return EventCard(eventsModel: eventsModel);
                      }),
                ),
              ));
  }
}
