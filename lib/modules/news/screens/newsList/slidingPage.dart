import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:IITDAPP/modules/news/data/newsData.dart';
import 'package:IITDAPP/modules/news/data/pageCarouselIndex.dart';
import 'package:IITDAPP/modules/news/widgets/cards/recentNewsWidget.dart';

class SlidingListPage<K extends NewsType> extends StatelessWidget {
  const SlidingListPage({
    Key key,
    @required this.width,
    this.data,
  }) : super(key: key);

  final double width;
  final List<NewsModel> data;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Provider.of<NewsProvider<K>>(context, listen: false).refresh(
            Provider.of<PageCarouselIndex>(context, listen: false).current);
      },
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, index) {
          return RecentWidget(
            width: width,
            item: data[index],
          );
        },
      ),
    );
  }
}
