import 'package:IITDAPP/modules/dashboard/widgets/errorWidget.dart';
import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/screens/newsList/newsListPage.dart';
import 'package:IITDAPP/modules/news/widgets/cards/recentNewsWidget.dart';
import 'package:IITDAPP/modules/news/widgets/sectionHeading.dart';
import 'package:IITDAPP/modules/news/widgets/shimmers/shimmerList.dart';
import 'package:IITDAPP/routes/Transitions.dart';
import 'package:IITDAPP/utility/apiResponse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentsSections extends StatelessWidget {
  RecentsSections({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final news = Provider.of<NewsProvider<RecentNews>>(context);
    var children;
    if (news.displayedData.status == Status.ERROR) {
      children = [
        Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
                child: ErrorDisplay(
                    refresh: news.refresh, error: news.displayedData.message))),
      ];
    } else if (news.displayedData.status == Status.LOADING) {
      children = [
        ShimmerList(itemCount: NewsProvider.itemsPerPage, width: width)
      ];
    } else {
      children = List.generate(
          NewsProvider.itemsPerPage > news.displayedData.data.length
              ? news.displayedData.data.length
              : NewsProvider.itemsPerPage,
          (index) =>
              RecentWidget(width: width, item: news.displayedData.data[index]));
    }
    return Column(children: [
      SectionHeading(
          text: 'Recent',
          onTap: () {
            Navigator.of(context).push(FadeRoute(
                page: NewsList<RecentNews>(
              title: 'Recent',
            )));
          }),
      ...children
    ]);
  }
}
