import 'dart:convert';
import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
import 'package:http/http.dart' as http;

import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './events/events_tab.dart';
import './clubs/clubs_tab.dart';
import './manage/manage_tab.dart';
import 'events/event_class.dart';
import 'globals.dart';

Future<List<List<List<Event>>>> getEvents() async {
  print('Getting Events');
  // ignore: omit_local_variable_types
  final LocalStorage localStorage = LocalStorage('iitdapp');
  var timeOutFlag = false;
  var returnObj;
  final response = await http.get('$uri/api/events',
      headers: {'authorization': 'Bearer $token'}).timeout(
    Duration(seconds: 5),
    onTimeout: () async {
      var parsedJson = await localStorage.getItem('events');
      returnObj = handleGetEventsSuccess(parsedJson);
      timeOutFlag = true;
      return null;
    },
  );
  connectedToInternet = !timeOutFlag;
  if (timeOutFlag) {
    return returnObj;
  }

  print(response.statusCode);
  if (response.statusCode == 200) {
    print('Events received');
    var parsedJson = json.decode(response.body);
    returnObj = handleGetEventsSuccess(parsedJson);
    await localStorage.setItem('events', parsedJson);
  } else {
    throw Exception('Failed to load events');
  }
  return returnObj;
}

// ignore: always_declare_return_types
handleGetEventsSuccess(var parsedJson) {
  todayEvents = List<List<Event>>.generate(3, (i) => []);
  tomorrowEvents = List<List<Event>>.generate(3, (i) => []);
  upcomingEvents = List<List<Event>>.generate(3, (i) => []);
  // ignore: prefer_collection_literals
  eventsList = [];
  if (parsedJson['message'] != 'Events Found') {
    return [todayEvents, tomorrowEvents, upcomingEvents];
  }
  print(parsedJson['data']['events'].length);
  for (var i = 0; i < parsedJson['data']['events'].length; i++) {
    var ev = Event.fromJson(parsedJson['data']['events'][i]);
    eventsList.add(ev);
  }
  return sortEvents();
}

// var a = getEvents();

class HomeScreen extends StatefulWidget {
  // final Function onlogout;
  static const String routeName = '/events';

  // HomeScreen({this.onlogout});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _controller;
  TabController _managetabcontroller;
  int _selectedTab = 1;
  List<Widget> _tabs;
  List<BottomNavigationBarItem> _navBarItems;

  Widget appBar;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventsTabProvider>(context, listen: false).getData();
    });
    _controller = TabController(length: 3, vsync: this);
    _managetabcontroller = TabController(length: 3, vsync: this);
    appBar = CustomAppBar(
      title: Text('$title'),
      height: 2,
      bottom: TabBar(
        indicatorColor: Colors.white70,
        controller: _controller,
        tabs: [
          Tab(text: 'TODAY'),
          Tab(text: 'TOMORROW'),
          Tab(text: 'UPCOMING'),
        ],
      ),
    );
    _tabs = [ClubsTab(), EventsTab(_controller)];
    _navBarItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: 'Clubs',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.event),
        label: 'Events',
      ),
    ];
    print(currentUser.isAdmin);
    if (currentUser.isAdmin || currentUser.isSSAdmin) {
      _tabs.add(ManageTab(_managetabcontroller));
      _navBarItems.add(BottomNavigationBarItem(
        icon: Icon(Icons.edit),
        label: 'Manage',
      ));
    }
    print(_tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<EventsTabProvider>(
    //   create: (context) => EventsTabProvider(),
    //   child: Builder(
    //     builder: (context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      key: scaffoldKey,
      drawer: AppDrawer(
        tag: 'Events',
      ),
      appBar: appBar,
      body: Container(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          connectedToInternet
              ? Container(
                  height: 0,
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Text(
                      'Cannot Connect to Server',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
          Expanded(child: _tabs[_selectedTab]),
        ],
      )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
        ),
        child: BottomNavigationBar(
          elevation: 1,
          backgroundColor:
              Provider.of<ThemeModel>(context).theme.BOTTOM_NAV_BACKGROUND,
          selectedItemColor:
              Provider.of<ThemeModel>(context).theme.BOTTOM_NAV_SELECTED,
          unselectedItemColor:
              Provider.of<ThemeModel>(context).theme.BOTTOM_NAV_UNSELECTED,
          currentIndex: _selectedTab,
          onTap: (int index) {
            setState(() {
              _selectedTab = index;
              if (index == 1) {
                appBar = CustomAppBar(
                  title: Text('$title'),
                  height: 2,
                  bottom: TabBar(
                    indicatorColor: Colors.white70,
                    controller: _controller,
                    tabs: [
                      Tab(text: 'TODAY'),
                      Tab(text: 'TOMORROW'),
                      Tab(text: 'UPCOMING'),
                    ],
                  ),
                );
              } else {
                appBar = CustomAppBar(
                  title: Text('$title'),
                );
              }
            });
          },
          items: _navBarItems,
        ),
      ),
    );
    // }));
  }
}
