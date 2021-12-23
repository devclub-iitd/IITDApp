// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: deprecated_member_use

import 'package:IITDAPP/modules/login/userlogin/profile_dialog.dart';
import 'package:IITDAPP/modules/map/data/mapCondition.dart';
import 'package:IITDAPP/modules/map/data/mapOffsets.dart';
import 'package:IITDAPP/modules/map/widgets/marker/marker.dart';
import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key key,
    @required this.duration,
  }) : super(key: key);

  final Duration duration;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with TickerProviderStateMixin {
  bool expanded = false;
  String query;
  AnimationController _controller;
  final duration = Duration(milliseconds: 300);
  final _searchInputControler = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchInputControler.addListener(changeQuery);
    _controller = AnimationController(duration: duration, vsync: this);
    BackButtonInterceptor.add(popOrClose);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(popOrClose);
    super.dispose();
  }

  void resetSearch() {
    _searchInputControler.text = '';
    query = '';
  }

  bool popOrClose(bool stopDefaultButtonEvent, _) {
    if (!expanded) {
      return false;
    }
    toggleExpansion();
    return true;
  }

  void changeQuery() {
    setState(() {
      query = _searchInputControler.text;
      //add controller
    });
  }

  @override
  Widget build(BuildContext context) {
    final conditions = Provider.of<MapConditions>(context, listen: false);
    final offsets = Provider.of<MapOffset>(context, listen: false);
    final markers = conditions.markers;
    List filtered = markers
        .where((m) =>
            m.location.name.toLowerCase().contains((query ?? '').toLowerCase()))
        .toList();
    return Align(
        alignment: Alignment.topCenter,
        child: AnimatedContainer(
            margin: expanded
                ? EdgeInsets.all(0)
                : EdgeInsets.only(top: 30, left: 10, right: 10),
            padding: expanded
                ? EdgeInsets.only(top: 42, left: 22, right: 22)
                : EdgeInsets.all(10),
            decoration: BoxDecoration(
                color:
                    Provider.of<ThemeModel>(context).theme.SLIDE_UP_SHEET_COLOR,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 0,
                      color: Theme.of(context).accentColor)
                ],
                border: Border.all(
                    width: expanded ? 0 : 2,
                    color: Theme.of(context).accentColor.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(expanded ? 0 : 10)),
            width: double.infinity,
            height: !expanded ? 50 : 1000,
            duration: duration,
            child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 25,
                          child: Row(children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                  onTap: () {
                                    if (!expanded) {
                                      Scaffold.of(context).openDrawer();
                                      return;
                                    }
                                    toggleExpansion();
                                  },
                                  child: AnimatedIcon(
                                      icon: AnimatedIcons.menu_arrow,
                                      color: Provider.of<ThemeModel>(context,
                                              listen: false)
                                          .theme
                                          .PRIMARY_TEXT_COLOR,
                                      progress: _controller)),
                            ),
                            Expanded(
                              child: GestureDetector(
                                behavior: expanded
                                    ? HitTestBehavior.deferToChild
                                    : HitTestBehavior.opaque,
                                onTap: toggleExpansion,
                                child: expanded
                                    ? TextField(
                                        controller: _searchInputControler,
                                        autofocus: true,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: 'Search',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(0),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.centerLeft,
                                        height: 25,
                                        child: Text('Search',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .hintColor)),
                                      ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => (!expanded)
                                  ? showAlert(context, logoutFunc)
                                  : setState(() => resetSearch()),
                              child: expanded
                                  ? Icon(Icons.cancel)
                                  : Transform.scale(
                                      scale: 1.8,
                                      child: FittedBox(child: PopupMenu())),
                            )
                          ])),
                      AnimatedContainer(
                        margin: expanded
                            ? EdgeInsets.only(top: 10)
                            : EdgeInsets.only(top: 0),
                        duration: duration,
                        height: !expanded
                            ? 0
                            : MediaQuery.of(context).size.height - 81,
                        child: ListView.builder(
                            itemCount: filtered.length,
                            itemBuilder: (_, i) => SearchOption(
                                  m: filtered[i],
                                  query: query ?? '',
                                  bgcolor: conditions.bgcolor[filtered[i].id],
                                  onTap: () {
                                    toggleExpansion();
                                    conditions.markerSelected(filtered[i].id);
                                    offsets.moveTo(filtered[i]);
                                  },
                                )),
                      )
                    ]))));
  }

  void toggleExpansion() {
    setState(() {
      resetSearch();
      expanded = !expanded;
      if (_controller.status == AnimationStatus.forward ||
          _controller.status == AnimationStatus.completed) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }
}

class SearchOption extends StatelessWidget {
  final Marker m;
  final Function onTap;
  final String query;
  final bgcolor;
  const SearchOption(
      {@required this.m,
      @required this.onTap,
      @required this.query,
      @required this.bgcolor});

  @override
  Widget build(BuildContext context) {
    if (query == '') {
      return ListTile(
        leading: Container(
          color: bgcolor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: m,
          ),
        ),
        title: Text(m.location.name),
        // RichText(
        //   text: TextSpan(children: [
        //     TextSpan(
        //       text: m.location.name.substring(0, substring),
        //     ),
        //     TextSpan(
        //       text: m.location.name.substring(substring, substring+(query??'').length),
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //     ),
        //     TextSpan(
        //       text: m.location.name.substring(substring+(query??'').length),
        //     ),
        //   ]),
        // ),
        onTap: onTap,
      );
    }
    var substring = m.location.name.toLowerCase().indexOf(query.toLowerCase());
    // print(m.location.name.substring(0, substring));
    // print(m.location.name.substring(substring, substring + (query).length));
    // print(m.location.name.substring(substring + (query).length));
    if (substring == -1) {
      substring = 0;
    }
    return ListTile(
      leading: Container(
        color: bgcolor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: m,
        ),
      ),
      title: RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style.apply(fontSizeDelta: 2),
            children: [
              TextSpan(
                text: m.location.name.substring(0, substring),
              ),
              TextSpan(
                text: m.location.name
                    .substring(substring, substring + (query).length),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: m.location.name.substring(substring + (query).length),
              ),
            ]),
      ),
      onTap: onTap,
    );
  }
}
