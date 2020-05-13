import 'package:IITDAPP/modules/explore/screens/ClubsListView.dart';
import 'package:IITDAPP/modules/explore/screens/HostelsListView.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {

  static const String routeName = '/explore';


  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with TickerProviderStateMixin {

  TabController _controller;
  Widget appBar;



  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);

    appBar = CustomAppBar(
      title: Text('EXPLORE'),
      height: 2,
//      actions: <Widget>[ProfileIcon()],
      bottom: TabBar(
        indicatorColor: Colors.white70,
        controller: _controller,
        tabs: [
          Tab(text: 'CLUBS & BOARDS'),
          Tab(text: 'HOSTELS'),
          Tab(text: 'HANGOUT'),
        ],
      ),
    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: AppDrawer(),
       body:  TabBarView(
          controller: _controller,
          children: [
            ClubsListView(),
            HostelsListView(),
            ClubsListView(),
          ],
        )
    );
  }
}
