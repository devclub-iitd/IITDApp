import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:IITDAPP/modules/news/data/carouselIndex.dart';
import 'package:IITDAPP/modules/news/screens/newsHome.dart';

class News extends StatelessWidget {
  static const String routeName = '/news';

  @override
  Widget build(BuildContext context) {
    print('built news');
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => CarouselIndex(),
      ),
    ], child: NewsHome());
  }
}
