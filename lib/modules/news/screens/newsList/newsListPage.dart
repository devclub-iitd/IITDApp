import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/data/pageCarouselIndex.dart';
import 'package:IITDAPP/modules/news/screens/newsList/pageRow.dart';
import 'package:IITDAPP/modules/news/screens/newsList/slidingPage.dart';
import 'package:IITDAPP/modules/news/widgets/shimmers/shimmerList.dart';
import 'package:IITDAPP/modules/news/widgets/shimmers/sizedShimmer.dart';
import 'package:IITDAPP/routes/Transitions.dart';
import 'package:IITDAPP/utility/apiResponse.dart';

import 'package:IITDAPP/ThemeModel.dart';
import 'package:IITDAPP/widgets/CustomAppBar.dart';

class NewsList<K extends NewsType> extends StatefulWidget {
  final String title;

  const NewsList({Key key, @required this.title}) : super(key: key);

  @override
  _NewsListState<K> createState() => _NewsListState<K>();
}

class _NewsListState<K extends NewsType> extends State<NewsList<K>> {
  String _value;
  @override
  void initState() {
    print(widget.title);
    _value = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeModel>(context).theme.SCAFFOLD_BACKGROUND,
      appBar: CustomAppBar(
        title: Theme(
          data: ThemeData.dark().copyWith(
              canvasColor:
                  Provider.of<ThemeModel>(context).theme.APP_BAR_START),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _value,
              items: <DropdownMenuItem<String>>[
                DropdownMenuItem(
                  value: 'Trending',
                  child: Text(
                    'Trending',
                    style: Theme.of(context).primaryTextTheme.headline6,
                  ),
                ),
                DropdownMenuItem(
                  value: 'Recent',
                  child: Text(
                    'Recent',
                    style: Theme.of(context).primaryTextTheme.headline6,
                  ),
                ),
                DropdownMenuItem(
                  value: 'Old',
                  child: Text(
                    'Old',
                    style: Theme.of(context).primaryTextTheme.headline6,
                  ),
                ),
              ],
              onChanged: (String value) {
                switch (value) {
                  case 'Recent':
                    Navigator.of(context).pushReplacement(
                        FadeRoute(page: NewsList<RecentNews>(title: value)));
                    break;
                  case 'Trending':
                    Navigator.of(context).pushReplacement(
                        FadeRoute(page: NewsList<TrendingNews>(title: value)));
                    break;
                  case 'Old':
                    Navigator.of(context).pushReplacement(
                        FadeRoute(page: NewsList<OldNews>(title: value)));
                    break;
                  default:
                }
              },
            ),
          ),
        ),
        withMenu: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Consumer<NewsProvider<K>>(
          builder: (_, news, child) {
            if (news.displayedData.status == Status.LOADING) {
              return Column(
                children: <Widget>[
                  Container(
                      height: height * 0.8,
                      child: ShimmerList(
                        itemCount: NewsProvider.itemsPerPage,
                        width: width,
                      )),
                  SizedShimmer(width: width - 100, height: 30)
                ],
              );
            }
            if (news.displayedData.status == Status.ERROR) {
              return Center(
                child: Text(news.displayedData.message),
              );
            }
            return ChangeNotifierProvider(
              create: (_) {
                var par = news.pageAfterRefresh;
                news.pageAfterRefresh = 0;
                return PageCarouselIndex(width, news.pages, par);
              },
              child: Stack(
                children: <Widget>[
                  child,
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: PageNumberRow(
                        width: width,
                      ))
                ],
              ),
            );
          },
          child: PageList<K>(width: width, height: height),
        ),
      ),
    );
  }
}

class PageList<K extends NewsType> extends StatelessWidget {
  const PageList({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final news = Provider.of<NewsProvider<K>>(context);
    final pci = Provider.of<PageCarouselIndex>(context, listen: false);
    if (news.displayedData.status == Status.LOADING) {
      return ShimmerList(
        itemCount: NewsProvider.itemsPerPage,
        width: width,
      );
    }
    if (news.displayedData.status == Status.ERROR) {
      return Center(child: Text(news.displayedData.message));
    }
    return CarouselSlider.builder(
        carouselController: pci.cc,
        itemCount: news.pages,
        itemBuilder: (_, index) {
          if (news.pageLoaded[index]) {
            return SlidingListPage<K>(
                width: width,
                data: news.displayedData.data.sublist(
                    index * NewsProvider.itemsPerPage,
                    min((index + 1) * NewsProvider.itemsPerPage,
                        news.maxNewsItems)));
          } else {
            return ShimmerList(
                itemCount: min(
                    4, news.maxNewsItems - index * NewsProvider.itemsPerPage),
                width: width);
          }
        },
        options: CarouselOptions(
          initialPage: pci.current,
          enableInfiniteScroll: false,
          onPageChanged: (index, r) {
            if (!pci.isAnimating) {
              pci.setCurrent(index);
            }
            if (!news.pageLoaded[index] &&
                !news.pageLoading[index] &&
                pci.current == index) {
              news.loadPage(index);
            }
          },
          height: height * 0.78,
          viewportFraction: 1,
          autoPlay: false,
        ));
  }
}
