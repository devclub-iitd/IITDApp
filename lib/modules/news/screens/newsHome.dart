import 'package:IITDAPP/modules/news/screens/reports/allReports.dart';
import 'package:IITDAPP/modules/news/utility/showSnackBarResult.dart';
import 'package:IITDAPP/values/Constants.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/widgets/sections/recentsSection.dart';
import 'package:IITDAPP/modules/news/widgets/sections/trendingSection.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';
import 'package:IITDAPP/widgets/Drawer.dart';

import 'newsUpdate.dart';

class NewsHome extends StatelessWidget {
  const NewsHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: CustomAppBar(
        title: Text('News'),
        actions: (!(currentUser.isSSAdmin || currentUser.isSuperAdmin))
            ? []
            : <Widget>[AddNewsButton(), AllReportsButton()],
      ),
      drawer: AppDrawer(
        tag: 'News',
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.wait([
            Provider.of<NewsProvider<TrendingNews>>(context, listen: false)
                .refresh(),
            Provider.of<NewsProvider<RecentNews>>(context, listen: false)
                .refresh()
          ]);
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

class AllReportsButton extends StatelessWidget {
  const AllReportsButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.report),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AllReports())));
  }
}

class AddNewsButton extends StatelessWidget {
  const AddNewsButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (c) => NewsUpdate(
                        nm: NewsModel(),
                        title: 'Create',
                      )));
          showSnackbarResult(result, Scaffold.of(context));
        });
  }
}
