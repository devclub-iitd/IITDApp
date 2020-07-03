import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsAuthor.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsClicks.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsTitle.dart';
import 'package:provider/provider.dart';

class Overlaytitle extends StatelessWidget {
  const Overlaytitle({
    Key key,
    @required this.item,
  }) : super(key: key);

  final NewsModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(150, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Consumer<NewsHistoryProvider>(
              builder: (_, nhp, c) => FutureBuilder(
                  future: nhp.getViewed(item.id),
                  builder: (_, AsyncSnapshot<bool> snapshot) =>
                      (!snapshot.hasData || !snapshot.data)
                          ? NewsTitle(
                              maxLines: 2,
                              title: item.title, size: 20, color: Colors.white)
                          : NewsTitle(
                              maxLines: 2,
                              title: item.title,
                              size: 20,
                              color: Colors.white54)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              NewsAuthor(
                author: item.author,
                color: Colors.white70,
                size: 12,
              ),
              NewsClicks(
                clicks: item.clicks,
                color: Colors.white70,
                size: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
