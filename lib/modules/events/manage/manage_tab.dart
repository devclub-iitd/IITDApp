import 'package:IITDAPP/modules/events/EventsTabProvider.dart';
import 'package:IITDAPP/modules/login/user_class.dart';
import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/sectionTitle.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

import './my_events_list.dart';
import './add_event_screen.dart';
// import '../events/event_class.dart';
import 'admins_screen/admin_screen.dart';

class ManageTab extends StatefulWidget {
  final TabController _controller;

  ManageTab(this._controller);

  @override
  State<StatefulWidget> createState() {
    return _ManageTabState();
  }
}

class _ManageTabState extends State<ManageTab> {
  // List<Event> events;
  UClub club = currentUser.adminof[0];
  // UClub club;
  int state = 1;
  TabController _controller;

  void _refresh() => setState(() {});

  // Future<List<Event>> getClubEvents(String id) async {
  //   print('getting club events');
  //   print(id);
  //   final response = await http.get('$url/api/events/?body=$id',
  //       headers: {'authorization': 'Bearer $token'});
  //   print(response.statusCode);
  //   // print(response.body);
  //   if (response.statusCode == 200) {
  //     var parsedJson = json.decode(response.body);
  //     // ignore: prefer_collection_literals
  //     var tevents = List<Event>();
  //     if (parsedJson['message'] != 'Events Found') {
  //       return tevents;
  //     } else {
  //       for (var i = 0; i < parsedJson['data']['events'].length; i++) {
  //         var ev = Event.fromJson(parsedJson['data']['events'][i]);
  //         tevents.add(ev);
  //       }
  //       return tevents;
  //     }
  //   } else {
  //     throw Exception('Failed to load events');
  //   }
  // }

  List<DropdownMenuItem<UClub>> clubList = [];

  void makeList() {
    clubList = [];
    for (var i = 0; i < currentUser.adminof.length; i++) {
      clubList.add(
        DropdownMenuItem(
          value: currentUser.adminof[i],
          child: AutoSizeText(
            currentUser.adminof[i].clubName,
            maxLines: 1,
          ),
        ),
      );
    }
  }

  Widget viewAdminButton() {
    if (currentUser.isSuperAdmin) {
      return FlatButton(
          color:
              Provider.of<ThemeModel>(context).theme.RAISED_BUTTON_BACKGROUND,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminScreen()));
          },
          child: Text(
            'VIEW ADMINS',
            style: TextStyle(
              color: Provider.of<ThemeModel>(context)
                  .theme
                  .RAISED_BUTTON_FOREGROUND,
            ),
          ));
    } else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    makeList();
    _controller = widget._controller;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      key: PageStorageKey('manageTab'),
      children: <Widget>[
        viewAdminButton(),
        // (currentUser.isSuperAdmin)
        //     ? FlatButton(
        //         color: Colors.indigo[400],
        //         onPressed: () {
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => AdminScreen()));
        //         },
        //         child: Text(
        //           'VIEW ADMINS',
        //           style: TextStyle(color: Colors.white),
        //         ),
        //       )
        //     : null,
        FlatButton(
          color:
              Provider.of<ThemeModel>(context).theme.RAISED_BUTTON_BACKGROUND,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddEvent()),
            ).then((value) {
              setState(() {});
            });
          },
          child: Text(
            'ADD NEW EVENT',
            style: TextStyle(
              color: Provider.of<ThemeModel>(context)
                  .theme
                  .RAISED_BUTTON_FOREGROUND,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SectionTitle(
                title: 'YOUR CLUB EVENTS',
              ),
              SectionUnderLine(),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: DropdownButtonFormField<UClub>(
            value: club,
            items: clubList,
            decoration: InputDecoration(
              labelText: 'Select Club',
              labelStyle: TextStyle(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              filled: true,
              fillColor: Color(0x0AAAAAAA),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Provider.of<ThemeModel>(context)
                      .theme
                      .PRIMARY_TEXT_COLOR
                      .withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    // color: Provider.of<ThemeModel>(context,listen:false).theme.PRIMARY_TEXT_COLOR,
                    ),
              ),
            ),
            onChanged: (value) async {
              if (club != value) {
                club = value;
                // setState(
                //   () {
                //     state = 0;
                //   },
                // );
                // await getClubEvents(club.id);
                setState(
                  () {
                    // state = 1;
                  },
                );
              }
            },
          ),
        ),
        Consumer<EventsTabProvider>(
          builder: (context, provider, child) {
            if (provider.error) {
              return Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Some Error Occured',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              );
            } else if (provider.loaded) {
              var _clubEvents = provider.allEvents
                  .where((element) => element.eventBody.id == club.id)
                  .toList();
              var _upcomingEvents = _clubEvents
                  .where((element) => element.endsAt.isAfter(DateTime.now()))
                  .toList();
              var _pastEvents = _clubEvents
                  .where((element) => element.endsAt.isBefore(DateTime.now()))
                  .toList();
              _upcomingEvents.sort((a, b) {
                // if (a.isStarred != b.isStarred) return (a.isStarred) ? 0 : 1;
                return a.startsAt.compareTo(b.startsAt);
              });
              _pastEvents.sort((a, b) {
                // if (a.isStarred != b.isStarred) return (a.isStarred) ? 0 : 1;
                return b.endsAt.compareTo(a.endsAt);
              });
              return
                  // DefaultTabController(
                  // child:
                  Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 2),
                    decoration: BoxDecoration(
                        color: Provider.of<ThemeModel>(context)
                            .theme
                            .DEFAULT_WIDGET_BACKGROUND,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              spreadRadius: 1,
                              color: Provider.of<ThemeModel>(context)
                                  .theme
                                  .PRIMARY_TEXT_COLOR
                                  .withOpacity(0.1))
                        ]),
                    child: TabBar(
                        controller: _controller,
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Theme.of(context)
                            .textTheme
                            .headline1
                            .color
                            .withOpacity(0.9),
                        tabs: [
                          Tab(
                            text: 'Upcoming',
                          ),
                          Tab(
                            text: 'Past',
                          )
                        ]),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: TabBarView(controller: _controller, children: [
                        MyEventsList(_upcomingEvents, _refresh),
                        MyEventsList(_pastEvents, _refresh),
                      ]))
                ],
              );
              // return MyEventsList(snapshot.data, _refresh);
            }

            return Container(
                margin: EdgeInsets.all(20),
                child: Center(
                    child: CircularProgressIndicator(
                        // valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )));
          },
        ),
      ],
    );
  }
}
