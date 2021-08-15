import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/modules/news/utility/showSnackBarResult.dart';
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
    final parentScaffold = Scaffold.of(context);
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        clipBehavior: Clip.antiAlias,
        foregroundDecoration: BoxDecoration(
            color: item.visible
                ? Colors.transparent
                : Provider.of<ThemeModel>(context)
                    .theme
                    .SCAFFOLD_BACKGROUND
                    .withOpacity(0.5)),
        decoration: BoxDecoration(
          color:
              Provider.of<ThemeModel>(context).theme.DEFAULT_WIDGET_BACKGROUND,
          borderRadius: BorderRadius.circular(5),
        ),
        width: width - 16,
        height: (width - 16) * 0.45 * 2 / 3,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            Provider.of<NewsHistoryProvider>(context, listen: false)
                .setViewed(item.id);
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NewsPage(
                  item: item,
                  imageTag: 'r${item.id}',
                  redirectPossible: true,
                ),
              ),
            );

            showSnackbarResult(result, parentScaffold);
          },
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
                      color: Theme.of(context)
                          .textTheme
                          .headline1
                          .color
                          .withOpacity(0.54),
                      size: 12.0,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: NewsDate(
                        createdAt: item.createdAt,
                        color: Theme.of(context)
                            .textTheme
                            .headline1
                            .color
                            .withOpacity(0.54),
                        size: 12.0,
                      )),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: NewsAuthor(
                        author: item.author,
                        size: 12,
                        color: Theme.of(context)
                            .textTheme
                            .headline1
                            .color
                            .withOpacity(0.54)),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: NewsClicks(
                      clicks: item.clicks,
                      size: 12,
                      color: Theme.of(context)
                          .textTheme
                          .headline1
                          .color
                          .withOpacity(0.54),
                    ),
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
                                      title: item.title,
                                      size: 14,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          .color
                                          .withOpacity(1))
                                  : NewsTitle(
                                      maxLines: 2,
                                      title: item.title,
                                      size: 14,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          .color
                                          .withOpacity(0.54))),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
