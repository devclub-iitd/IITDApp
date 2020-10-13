import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsDate.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsSource.dart';
import 'package:IITDAPP/modules/news/data/newsData.dart';

class OverlayHeading extends StatelessWidget {
  final NewsModel item;

  OverlayHeading({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(0, 0, 0, 0), Color.fromARGB(150, 0, 0, 0)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          NewsSource(
            sourceName: item.sourceName,
            color: Colors.white70,
            size: 12,
          ),
          NewsDate(
            createdAt: item.createdAt,
            color: Colors.white70,
            size: 12,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
