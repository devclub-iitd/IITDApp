import 'package:IITDAPP/modules/dashboard/widgets/errorWidget.dart';
import 'package:IITDAPP/modules/news/screens/resportsList.dart';
import 'package:IITDAPP/modules/news/widgets/reportScreen.dart';
import 'package:IITDAPP/utility/apiResponse.dart';
import 'package:IITDAPP/values/colors/Constants.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';

import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/newsImage.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsAuthor.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsClicks.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsDate.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsTitle.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsSource.dart';
import 'package:IITDAPP/modules/news/widgets/shimmers/shimmerSection.dart';
import 'package:IITDAPP/values/colors/colors.dart';
import 'newsUpdate.dart';

class NewsPage extends StatelessWidget {
  final NewsModel item;
  final String imageTag;
  const NewsPage({Key key, this.item, this.imageTag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    item.getDetails();
    return ChangeNotifierProvider.value(
      value: item,
      builder: (_, c) => Scaffold(
        body: Consumer<NewsModel>(
          builder: (_, syncItem, c) => CustomScrollView(
            slivers: <Widget>[
              SliverGradientAppBar(
                actions: (!currentUser.isAdmin)
                    ? []
                    : <Widget>[
                        EditButton(item: syncItem),
                        DeleteButton(item: syncItem),
                      ],
                floating: false,
                pinned: true,
                snap: false,
                backgroundColorStart: AppColors.APP_BAR_START,
                backgroundColorEnd: AppColors.APP_BAR_END,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: imageTag,
                    child: NewsImage(url: syncItem.imgUrl),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        NewsSource(
                          sourceName: syncItem.sourceName,
                          size: 15,
                          color: Colors.white70,
                        ),
                        NewsDate(
                          createdAt: syncItem.createdAt,
                          size: 15,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: NewsTitle(
                      title: syncItem.title,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        NewsAuthor(
                          author: syncItem.author,
                          size: 15,
                          color: Colors.white70,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: NewsClicks(
                            clicks: syncItem.clicks,
                            size: 15,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    endIndent: 5,
                    indent: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 20),
                    child: syncItem.details.status == Status.LOADING
                        ? ShimmerSection()
                        : (syncItem.details.status == Status.ERROR
                            ? ErrorDisplay(
                                refresh: syncItem.getDetails,
                                error: syncItem.details.message)
                            : Text(syncItem.details.data,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))),
                  ),
                  currentUser.isAdmin
                      ? FlatButton(
                          color: Colors.blueGrey.withOpacity(0.1),
                          child: Text('View Reports',
                              style: TextStyle(
                                fontSize: 15,
                                color: (syncItem.details.status ==
                                            Status.COMPLETED &&
                                        syncItem.reports.isNotEmpty)
                                    ? Colors.white
                                    : Colors.white38,
                              )),
                          onPressed: () {
                            if (syncItem.details.status == Status.COMPLETED) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ReportsList(syncItem.reports),
                              ));
                            }
                          })
                      : FlatButton(
                          child: Text(
                            'Report This Article',
                            style:
                                TextStyle(color: Colors.white54, fontSize: 15),
                          ),
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ReportScreen(
                              item: syncItem,
                            ),
                          )),
                        ),
                  if (item.details.status == Status.COMPLETED)
                    Container(
                      alignment: Alignment.bottomRight,
                      color: Colors.blueGrey.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Article Revisions : ${syncItem.version}',style: TextStyle(color:Colors.white54,fontSize: 12),),
                      ),
                    ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key key,
    @required this.item,
  }) : super(key: key);

  final NewsModel<NewsType> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 50)]),
      child: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Deleting, Please Wait'),
            ));
            item.delete().then((value) async {
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(value),
                duration: Duration(seconds: 1),
              ));
              unawaited(Provider.of<NewsProvider<TrendingNews>>(context,
                      listen: false)
                  .refresh());
              await Provider.of<NewsProvider<RecentNews>>(context,
                      listen: false)
                  .refresh();
            }).then((value) => Navigator.pop(context));
          }),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    Key key,
    @required this.item,
  }) : super(key: key);

  final NewsModel<NewsType> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 50)]),
      child: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => NewsUpdate(
                          nm: item,
                          title: 'Update',
                        )));
          }),
    );
  }
}
