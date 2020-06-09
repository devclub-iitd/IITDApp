import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:IITDAPP/globals.dart';
import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/widgets/sections/recentsSection.dart';
import 'package:IITDAPP/modules/news/widgets/sections/trendingSection.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';

import 'newsUpdate.dart';

class NewsHome extends StatelessWidget {
  NewsHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('News'),
        actions: (!currentUser.isAdmin)
            ? []
            : <Widget>[
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => NewsUpdate(
                                    nm: NewsModel(),
                                    title: 'Create',
                                  )));
                    })
              ],
      ),
      drawer: AppDrawer(
        tag: 'News',
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Provider.of<NewsProvider<TrendingNews>>(context, listen: false)
              .refresh()
              .then((value) =>
                  Provider.of<NewsProvider<RecentNews>>(context, listen: false)
                      .refresh());
        },
        child: SingleChildScrollView(
            child: Column(children: [
          TrendingSection(),
          RecentsSections(),
        ])),
      ),
    );
  }
}
