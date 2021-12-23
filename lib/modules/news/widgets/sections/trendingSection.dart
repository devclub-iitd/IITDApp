import 'dart:math';

import 'package:IITDAPP/modules/dashboard/widgets/errorWidget.dart';
import 'package:IITDAPP/modules/news/data/carouselIndex.dart';
import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/screens/newsList/newsListPage.dart';
import 'package:IITDAPP/modules/news/widgets/cards/trendingNewsWidget.dart';
import 'package:IITDAPP/modules/news/widgets/indicators.dart';
import 'package:IITDAPP/modules/news/widgets/sectionHeading.dart';
import 'package:IITDAPP/modules/news/widgets/shimmers/sizedShimmer.dart';
import 'package:IITDAPP/routes/Transitions.dart';
import 'package:IITDAPP/utility/apiResponse.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print('built trending');
    print("called provider on trending news");
    final news = Provider.of<NewsProvider<TrendingNews>>(context);
    print("called provider on trending news and done");
    if (news.displayedData.status == Status.ERROR) {
      return Column(
        children: <Widget>[
          SectionHeading(
            text: 'Trending',
            onTap: () {
              Navigator.of(context).push(FadeRoute(
                  page: NewsList<TrendingNews>(
                title: 'Trending',
              )));
            },
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                  child: ErrorDisplay(
                      refresh: news.refresh,
                      error: news.displayedData.message))),
        ],
      );
    }
    var indicator, carousel;
    if (news.displayedData.status == Status.LOADING) {
      carousel = Container(
          margin: EdgeInsets.all(5),
          child: SizedShimmer(width: width, height: width * 2 / 3 - 10));
      indicator = Container(
          margin: EdgeInsets.all(5),
          child: SizedShimmer(width: width / 4, height: 15));
    } else {
      carousel = Container(
        margin: EdgeInsets.all(5),
        width: width,
        height: width * 2 / 3 - 10,
        child: Center(
          child: Text(
            'No News',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      );
      if (news.displayedData.data.isNotEmpty) {
        indicator = Indicators(
          length: NewsProvider.itemsPerPage > news.displayedData.data.length
              ? news.displayedData.data.length
              : NewsProvider.itemsPerPage,
        );
        carousel = CarouselSlider.builder(
            itemCount: min(NewsProvider.itemsPerPage, news.maxNewsItems),
            itemBuilder: (_, index) => TrendingWidget(
                width: width, item: news.displayedData.data[index]),
            options: CarouselOptions(
                autoPlay: true,
                height: width * 2 / 3,
                viewportFraction: 1,
                onPageChanged: (index, r) {
                  Provider.of<CarouselIndex>(context, listen: false)
                      .setCurrent(index);
                }));
      }
    }
    return Column(children: [
      SectionHeading(
        text: 'Trending',
        onTap: () {
          Navigator.of(context).push(FadeRoute(
              page: NewsList<TrendingNews>(
            title: 'Trending',
          )));
        },
      ),
      carousel,
      indicator ?? Text(''),
      Divider(height: 1, thickness: 1)
    ]);
  }
}
