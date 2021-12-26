// import 'package:IITDAPP/modules/attendance/attendance.dart';
// import 'package:IITDAPP/modules/attendance/data/attendanceModel.dart';
// import 'package:IITDAPP/modules/attendance/data/attendanceProvider.dart';
// ignore_for_file: deprecated_member_use

import 'package:IITDAPP/modules/dashboard/data/currentTabProvider.dart';
import 'package:IITDAPP/modules/dashboard/data/eventsProvider.dart';
import 'package:IITDAPP/modules/dashboard/data/tabDataProvider.dart';
import 'package:IITDAPP/modules/dashboard/widgets/errorWidget.dart';
import 'package:IITDAPP/modules/dashboard/widgets/loadingWIdget.dart';
import 'package:IITDAPP/modules/events/events/event_class.dart';
import 'package:IITDAPP/modules/events/home.dart';
import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/news.dart';
import 'package:IITDAPP/modules/news/screens/newsPage.dart';
import 'package:IITDAPP/utility/apiResponse.dart';
import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

class GeneralTab extends StatefulWidget {
  final ScrollController parentScrollController;
  final List<dynamic> tabData;
  final ApiResponse apiResponse;
  final Function refresh;
  final Function viewed;
  final Function subtitle;
  final Function title;
  final Function trailing;
  final String routeName;
  final List<int> newAlerts;
  final int index;
  const GeneralTab({
    Key key,
    @required this.parentScrollController,
    @required this.tabData,
    @required this.apiResponse,
    @required this.refresh,
    @required this.title,
    @required this.subtitle,
    @required this.trailing,
    @required this.routeName,
    @required this.newAlerts,
    this.viewed,
    @required this.index,
  }) : super(key: key);

  @override
  _GeneralTabState createState() => _GeneralTabState();
}

class _GeneralTabState extends State<GeneralTab> {
  ScrollController controller;
  Function filter;
  @override
  void initState() {
    controller = ScrollController();
    controller.removeListener(
        () => scrollToBottom(controller, widget.parentScrollController));
    controller.addListener(
        () => scrollToBottom(controller, widget.parentScrollController));
    super.initState();
  }

  void scrollToBottom(
      ScrollController controller, ScrollController parentScrollController) {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      parentScrollController.animateTo(
          parentScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.apiResponse.status == Status.LOADING) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: LoadingWidget(height: 75),
      );
    } else if (widget.apiResponse.status == Status.ERROR) {
      return ErrorDisplay(
          refresh: widget.refresh, error: widget.apiResponse.message);
    }
    var tabData = widget.apiResponse.data;
    if (tabData.length > 5) {
      tabData.length = 5;
    }
    if (Provider.of<CurrentTabProvider>(context, listen: false)
        .isCurrent(widget.index)) {
      widget.viewed();
      print('built ${tabData.length}');
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: tabData.length == 0
          ? Center(
              child: Text('Nothing New',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
            )
          : ListView.separated(
              controller: controller,
              itemBuilder: (_, i) => Container(
                    decoration: BoxDecoration(
                        color: widget.newAlerts.contains(i)
                            ? Provider.of<ThemeModel>(context)
                                .theme
                                .DEFAULT_HIGHLIGHT_BACKGROUND
                            : Provider.of<ThemeModel>(context)
                                .theme
                                .DEFAULT_WIDGET_BACKGROUND,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              spreadRadius: 1,
                              color: Provider.of<ThemeModel>(context,
                                      listen: false)
                                  .theme
                                  .PRIMARY_TEXT_COLOR
                                  .withOpacity(0.1))
                        ]),
                    child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16),
                        dense: true,
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            widget.title(tabData[i]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: Provider.of<ThemeModel>(context)
                                    .theme
                                    .PRIMARY_TEXT_COLOR),
                          ),
                        ),
                        subtitle: Text(
                          widget.subtitle(tabData[i]),
                          style: TextStyle(
                              fontSize: 14,
                              color: Provider.of<ThemeModel>(context)
                                  .theme
                                  .PRIMARY_TEXT_COLOR
                                  .withOpacity(0.7)),
                        ),
                        trailing: Text(
                          widget.trailing(tabData[i]),
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                        onTap: () {
                          Provider.of<NewsHistoryProvider>(context,
                                  listen: false)
                              .setViewed(tabData[i].id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NewsPage(
                                item: tabData[i],
                                imageTag: 't${tabData[i].id}',
                                redirectPossible: true,
                              ),
                            ),
                          );
                        }

                        //  Navigator.pushReplacementNamed(
                        //     context, widget.routeName),
                        ),
                  ),
              separatorBuilder: (_, i) => Divider(
                    height: 10,
                    thickness: 0,
                  ),
              itemCount: tabData.length),
    );
    // return Container();
  }
}

class EventsTab extends StatelessWidget {
  final ScrollController parentScrollController;
  final List<dynamic> tabData;
  const EventsTab({
    Key key,
    this.parentScrollController,
    this.tabData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ep = Provider.of<EventsProvider>(context, listen: false);
    return Consumer<TabDataProvider<EventsProvider>>(builder: (_, tdp, c) {
      return GeneralTab(
        index: 1,
        viewed: tdp.viewed,
        apiResponse: tdp.data,
        newAlerts: tdp.alerts,
        parentScrollController: parentScrollController,
        refresh: ep.getUpcomingEvents,
        routeName: HomeScreen.routeName,
        subtitle: (Event item) => item.eventBody.clubName,
        title: (Event item) => item.eventName,
        tabData: tabData,
        trailing: (Event item) => DateTime.now()
                .isBefore(item.startsAt.subtract(Duration(minutes: 330)))
            ? timeago.format(item.startsAt.subtract(Duration(minutes: 330)),
                allowFromNow: true)
            : 'ongoing',
      );
    });
  }
}

class NewsTab extends StatelessWidget {
  final ScrollController parentScrollController;
  final List<dynamic> tabData;

  const NewsTab({Key key, this.parentScrollController, this.tabData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var np = Provider.of<NewsProvider<RecentNews>>(context, listen: false);
    // print();
    return Consumer<TabDataProvider<NewsProvider<RecentNews>>>(
        builder: (_, tdp, c) {
      if (tdp != null) {
        return GeneralTab(
          index: 2,
          viewed: tdp.viewed,
          apiResponse: tdp.data,
          newAlerts: tdp.alerts,
          parentScrollController: parentScrollController,
          refresh: np.refresh,
          routeName: News.routeName,
          subtitle: (item) => item.author + ' - ' + item.sourceName,
          title: (item) => item.title,
          tabData: tabData,
          trailing: (item) => timeago.format(item.createdAt
              .subtract(Duration(minutes: 330))), //330 minute difference
        );
      }
      return Container();
    });
  }
}

// class AttendanceTab extends StatelessWidget {
//   final ScrollController parentScrollController;
//   final List<dynamic> tabData;

//   const AttendanceTab(
//       {Key key, @required this.parentScrollController, @required this.tabData})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var ap = Provider.of<AttendanceProvider>(context, listen: false);
//     ap.setEntryNumber('2019CS10382');
//     return Consumer<TabDataProvider<AttendanceProvider>>(builder: (_, tdp, c) {
//       return GeneralTab(
//         apiResponse: tdp.data,
//         index: 0,
//         // filter:(List<AttendanceModel> item)=> item.where((am)=>
//         //     (am.daysPresent / (am.daysPresent + am.daysAbsent) )<0.75).toList(),
//         viewed: tdp.viewed,
//         newAlerts: tdp.alerts,
//         parentScrollController: parentScrollController,
//         refresh: ap.fetchData,
//         routeName: Attendance.routeName,
//         subtitle: (AttendanceModel item) => item.abbr,
//         title: (AttendanceModel item) => item.name,
//         tabData: tabData,
//         trailing: (AttendanceModel item) =>
//             (item.daysPresent / (item.daysPresent + item.daysAbsent) * 100)
//                 .round()
//                 .toString() +
//             '%',
//       );
//     });
//   }
// }
