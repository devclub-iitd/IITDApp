import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/news/screens/newsPage.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/newsImage.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsAuthor.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsDate.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsTitle.dart';
import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:provider/provider.dart';
import 'imageOverlay/text/newsClicks.dart';
import 'imageOverlay/text/newsSource.dart';

class RecentWidget extends StatelessWidget {
  const RecentWidget({
    Key key,
    @required this.width,
    this.item,
  }) : super(key: key);

  final double width;
  final NewsModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(5),
        ),
        width: width - 16,
        height: (width - 16) * 0.45 * 2 / 3,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                width: (width - 16) * 0.45,
                child: Hero(
                  tag: 'r${item.id}',
                  child: NewsImage(
                    url: item.imgUrl,
                    width: (width - 16) * 0.45,
                    height: (width - 16) * 0.45 * 2 / 3,
                  ),
                ),
              ),
            ),
            Container(
              height: (width - 16) * 0.45 * 2 / 3,
              width: (width - 16) * 0.55,
              padding: EdgeInsets.all(10),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 0,
                    top: 0,
                    child: NewsSource(
                      sourceName: item.sourceName,
                      color: Colors.white54,
                      size: 12.0,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: NewsDate(
                        createdAt: item.createdAt,
                        color: Colors.white54,
                        size: 12.0,
                      )),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: NewsAuthor(
                        author: item.author, size: 12, color: Colors.white54),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: NewsClicks(
                        clicks: item.clicks, size: 12, color: Colors.white54),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Consumer<NewsHistoryProvider>(
              builder: (_, nhp, c) => FutureBuilder(
                  future: nhp.getViewed(item.id),
                  builder: (_, AsyncSnapshot<bool> snapshot) =>
                      (!snapshot.hasData || !snapshot.data)
                          ? NewsTitle(
                              maxLines: 2,
                              title: item.title, size: 14, color: Colors.white)
                          : NewsTitle(
                              maxLines: 2,
                              title: item.title,
                              size: 14,
                              color: Colors.white54)),
            ),
                  )
                ],
              ),
            )
          ]),
          onTap: () {
            Provider.of<NewsHistoryProvider>(context,listen: false).setViewed(item.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NewsPage(
                  item: item,
                  imageTag: 'r${item.id}',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
