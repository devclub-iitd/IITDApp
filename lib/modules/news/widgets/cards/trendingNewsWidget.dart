import 'package:IITDAPP/modules/news/utility/showSnackBarResult.dart';
import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/news/screens/newsPage.dart';
import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:provider/provider.dart';
import 'imageOverlay/newsImage.dart';
import 'imageOverlay/overlayTitle.dart';
import 'imageOverlay/overlayHeading.dart';
import 'package:IITDAPP/values/Constants.dart';

class TrendingWidget extends StatelessWidget {
  const TrendingWidget({
    Key key,
    @required this.width,
    this.item,
  }) : super(key: key);

  final double width;
  final NewsModel item;

  @override
  Widget build(BuildContext context) {
    final parentScaffold = Scaffold.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        Provider.of<NewsHistoryProvider>(context, listen: false)
            .setViewed(item.id);
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NewsPage(
              item: item,
              imageTag: 't${item.id}',
              redirectPossible: true,
            ),
          ),
        );

        showSnackbarResult(result, parentScaffold);
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Hero(
                  tag: 't${item.id}',
                  child: NewsImage(
                    url: item.imgUrl,
                    height: width * 2 / 3,
                  )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Overlaytitle(item: item),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: OverlayHeading(item: item),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
