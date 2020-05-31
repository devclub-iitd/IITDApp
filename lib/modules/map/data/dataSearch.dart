import 'package:IITDAPP/modules/map/data/mapOffsets.dart';
import 'package:flutter/material.dart';
import 'package:IITDAPP/modules/map/data/mapCondition.dart';
import 'package:IITDAPP/modules/map/widgets/marker/marker.dart';

class DataSearch extends SearchDelegate<String> {
  final MapConditions conditions;
  final MapOffset offsets;

  DataSearch({this.conditions, this.offsets});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('re');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var resultList = conditions.markers
        .where((m) => (conditions.isVisible(m.location.type) &&
            m.location.name.toLowerCase().contains(query.toLowerCase())))
        .toList();
    resultList.sort((a, b) => a.location.name.compareTo(b.location.name));
    var widgetList = resultList
        .map((m) => SearchOption(
              m: m,
              query: query,
              bgcolor: conditions.bgcolor[m.id],
              onTap: () {
                close(context, null);
                conditions.markerSelected(m.id);
                offsets.moveTo(m);
              },
            ))
        .toList();
    return widgetList.isEmpty
        ? Center(
            child: Text('No results',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 25)))
        : ListView.builder(
            itemCount: widgetList.length,
            itemBuilder: (_, index) => widgetList[index]);
  }
}

class SearchOption extends StatelessWidget {
  final Marker m;
  final Function onTap;
  final String query;
  final bgcolor;
  SearchOption(
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
