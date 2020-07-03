import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './events/events_tab.dart';
import './clubs/clubs_tab.dart';
import './manage/manage_tab.dart';

class HomeScreen extends StatefulWidget {
  final Function onlogout;
  static const String routeName = '/events';

  HomeScreen({this.onlogout});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _controller;
  int _selectedTab = 1;
  List<Widget> _tabs;
  List<BottomNavigationBarItem> _navBarItems;

  Widget appBar;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
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
        title: Text('Clubs'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.event),
        title: Text('Events'),
      ),
    ];
    if (currentUser.isAdmin) {
      _tabs.add(ManageTab());
      _navBarItems.add(BottomNavigationBarItem(
        icon: Icon(Icons.edit),
        title: Text('Manage'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
