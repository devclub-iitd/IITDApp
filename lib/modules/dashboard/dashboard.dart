import 'package:IITDAPP/modules/attendance/data/attendanceModel.dart';
import 'package:IITDAPP/modules/attendance/data/attendanceProvider.dart';
import 'package:IITDAPP/modules/dashboard/data/currentTabProvider.dart';
import 'package:IITDAPP/modules/dashboard/data/dashboardAlerts.dart';
import 'package:IITDAPP/modules/dashboard/data/eventsProvider.dart';
import 'package:IITDAPP/modules/dashboard/data/tabDataProvider.dart';
import 'package:IITDAPP/modules/dashboard/widgets/tab/tab.dart';
import 'package:IITDAPP/modules/dashboard/widgets/tab/tabHead.dart';
import 'package:IITDAPP/modules/dashboard/widgets/userWidgets.dart';
import 'package:IITDAPP/modules/login/RequestLoginScreen.dart';
import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = '/dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  TabController _tabController;
  List<Tab> tabList = [];
  List<List<dynamic>> tabData = [[], [], []];
  TabDataProvider<AttendanceProvider> atdp;
  TabDataProvider<NewsProvider<RecentNews>> ntdp;
  TabDataProvider<EventsProvider> etdp;
  CurrentTabProvider ctp;
  final DashboardAlerts dashboardAlerts = DashboardAlerts();
  final EventsProvider eventsProvider = EventsProvider();

  @override
  void initState() {
    ctp = CurrentTabProvider();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      // print(_tabController.index);
      ctp.setCurrent(_tabController.index);
      print('set current ${_tabController.index}');
      if (_tabController.previousIndex != null) {
        switch (_tabController.previousIndex) {
          case 0:
            atdp.refreshAlerts();
            break;
          case 1:
            etdp.refreshAlerts();
            break;
          case 2:
            ntdp.refreshAlerts();
            break;
          default:
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    print('disposing dashboard');
    atdp.dispose();
    etdp.dispose();
    ntdp.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void initializeTabs(context) {
    tabList.clear();
    if (atdp == null) {
      atdp = (TabDataProvider<AttendanceProvider>(
          cnp: Provider.of<AttendanceProvider>(context, listen: false),
          getCacheData: (AttendanceProvider item) => item.data,
          da: dashboardAlerts,
          filter: (List<AttendanceModel> items) => items
              .where((element) =>
                  element.daysPresent /
                      (element.daysAbsent + element.daysPresent) <
                  0.75)
              .toList()));
      etdp = (TabDataProvider<EventsProvider>(
        cnp: eventsProvider,
        getCacheData: (EventsProvider item) => item.upcomingEvents,
        da: dashboardAlerts,
      ));
      ntdp = (TabDataProvider<NewsProvider<RecentNews>>(
          cnp: Provider.of<NewsProvider<RecentNews>>(context, listen: false),
          getCacheData: (NewsProvider<RecentNews> item) => item.displayedData,
          da: dashboardAlerts,
          limit: 4));
    }
    tabList.add(Tab(child: TabHead<AttendanceProvider>(title: 'Attendance')));
    tabList.add(Tab(
        child: TabHead<EventsProvider>(
      title: 'Events',
    )));
    tabList.add(Tab(child: TabHead<NewsProvider<RecentNews>>(title: 'News')));
  }

  @override
  Widget build(BuildContext context) {
    var _parentScrollController = ScrollController();
    initializeTabs(context);
    if (currentUser == null) {
      return RequestLoginScreen('User Dashboard');
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('User Dashboard'),
      ),
      drawer: AppDrawer(
        tag: 'User Dashboard',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return Future.wait([
            Provider.of<NewsProvider<RecentNews>>(context, listen: false)
                .refresh(0),
            Provider.of<AttendanceProvider>(context, listen: false).fetchData(),
            eventsProvider.getUpcomingEvents()
          ]);
        },
        child: SingleChildScrollView(
          controller: _parentScrollController,
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: eventsProvider),
              ChangeNotifierProvider.value(value: atdp),
              ChangeNotifierProvider.value(value: etdp),
              ChangeNotifierProvider.value(value: ntdp),
              ChangeNotifierProvider.value(value: ctp),
            ],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                UserImage(),
                UserName(),
                UserEmail(),
                SignOutButton(),
                Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: tabList),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: TabBarView(
                      controller: _tabController,
                      children: tabList
                          .map((e) => _getTab(
                              tabList.indexOf(e), _parentScrollController))
                          .toList()),
                )
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _getTab(int tabIndex, ScrollController parentScrollController) {
    switch (tabIndex) {
      case 0:
        return AttendanceTab(
            parentScrollController: parentScrollController,
            tabData: tabData[0]);
        break;
      case 1:
        return EventsTab(
            parentScrollController: parentScrollController,
            tabData: tabData[1]);
        break;
      case 2:
        return NewsTab(
            parentScrollController: parentScrollController,
            tabData: tabData[2]);
        break;
      default:
    }
    return Text('No');
  }
}
