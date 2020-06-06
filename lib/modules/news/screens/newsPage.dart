import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:provider/provider.dart';

import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/newsImage.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsAuthor.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsClicks.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsDate.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsTitle.dart';
import 'package:IITDAPP/modules/news/widgets/cards/imageOverlay/text/newsSource.dart';
import 'package:IITDAPP/modules/news/widgets/reportDialog.dart';
import 'package:IITDAPP/modules/news/widgets/shimmers/shimmerSection.dart';
import 'package:IITDAPP/values/colors/colors.dart';
import 'package:IITDAPP/globals.dart';
import 'newsUpdate.dart';

class NewsPage extends StatelessWidget {
  final NewsModel item;
  final String imageTag;
  const NewsPage({Key key, this.item, this.imageTag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverGradientAppBar(
            actions: (!currentUser.isAdmin)
                ? []
                : <Widget>[
                    EditButton(item: item),
                    DeleteButton(item: item),
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
                child: NewsImage(url: item.imgUrl),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    NewsSource(
                      sourceName: item.sourceName,
                      size: 15,
                      color: Colors.black87,
                    ),
                    NewsDate(
                      createdAt: item.createdAt,
                      size: 15,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: NewsTitle(
                  title: item.title,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    NewsAuthor(
                      author: item.author,
                      size: 15,
                      color: Colors.black87,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: NewsClicks(
                            clicks: item.clicks,
                            size: 15,
                            color: Colors.black87,
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 2,
                          color: Colors.black54,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.report,
                            color: Colors.black,
                          ),
                          onPressed: () => showDialog(
                            context: context,
                            child: ReportDialog(item: item,),
                          ),
                        )
                      ],
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                child: FutureBuilder(
                  future: item.content,
                  builder: (_, AsyncSnapshot<String> _snapshot) {
                    if (!_snapshot.hasData) {
                      return ShimmerSection();
                    } else {
                      return Text(_snapshot.data,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400));
                    }
                  },
                ),
              ),
            ]),
          )
        ],
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
    return IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Deleting, Please Wait'),duration: Duration(seconds:2),));
          item.delete().then((value) {
          Provider.of<NewsProvider<TrendingNews>>(context,
                  listen: false)
              .refresh();
          Provider.of<NewsProvider<RecentNews>>(context,
                  listen: false)
              .refresh();
          }).then((value) => 
                  Navigator.pop(context));
        });
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
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (c) => NewsUpdate(
                        nm: item,
                        title: 'Update',
                      )));
        });
  }
}
