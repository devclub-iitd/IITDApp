import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
// import 'package:IITDAPP/values/Constants.dart';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

// import 'package:IITDAPP/modules/events/globals.dart';
// import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
// import '../home.dart';
import './events_page.dart';
// import './event_class.dart';

Widget loadingIcon(context) {
  return Center(
    child: CircularProgressIndicator(
        // valueColor: AlwaysStoppedAnimation<Color>(
        //     Provider.of<ThemeModel>(context,listen:false).theme.PRIMARY_TEXT_COLOR),
        ),
  );
}

Widget errorMessage(context) {
  return Center(
    child: Text(
      'Some Error Occured',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w200,
      ),
    ),
  );
}

// var aaa = Provider.of<EventsTabProvider>(null).getData();

class EventsTab extends StatelessWidget {
  final TabController _controller;

  EventsTab(this._controller);

//   @override
//   State<StatefulWidget> createState() {
//     return EventsTabState();
//   }
// }

// class EventsTabState extends State<EventsTab> {
//   TabController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = widget._controller;
//   }

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<EventsTabProvider>(
    //     create: (context) => EventsTabProvider(),
    //     child: Builder(
    //         // FutureBuilder(
    //         // future: a,
    //         // builder: (context, snapshot) {
    //         builder: (context) {
          return Consumer<EventsTabProvider>(
            builder: (context, provider, child) {
              if (provider.error) {
                // print(snapshot.data);
                return TabBarView(
                  controller: _controller,
                  children: [
                    errorMessage(context),
                    errorMessage(context),
                    errorMessage(context),
                  ],
                );
              } else if (provider.loaded) {
                return TabBarView(
                  controller: _controller,
                  children: [
                    EventsPage('TODAY'),
                    EventsPage('TOMORROW'),
                    EventsPage('UPCOMING'),
                  ],
                );
              }
              return TabBarView(
                controller: _controller,
                children: [
                  loadingIcon(context),
                  loadingIcon(context),
                  loadingIcon(context),
                ],
              );
            },
          );
        // }));
  }
}
