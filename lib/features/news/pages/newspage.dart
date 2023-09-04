import 'package:flutter/material.dart';
import 'package:iitd_app/core/apiservices.dart';
import 'package:iitd_app/features/drawer.dart';
import 'package:iitd_app/features/news/components/newscomponents.dart';
import 'package:iitd_app/models/newsmodel.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsModel> newslist = [];
  @override
  void initState() {
    NewsAPI().fetchAllNews().then((value) {
      setState(() {
        newslist = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    newslist.shuffle();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const BoldText(
          title: "News",
          size: 24,
          textcolor: AppColors.backgroundColor,
        ),
        backgroundColor: AppColors.primaryColorDark,
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NewsComponent(
                newsList: newslist,
              ),
              const SizedBox(
                height: 8.0,
              ),
              const BoldText(title: "News", size: 22, textcolor: Colors.black),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                width: 100,
                height: 3,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(1.5)),
                    color: AppColors.greenShadeColor),
              ),
              NewsListView(
                list: newslist,
              )
            ],
          ),
        ),
      ),
    );
  }
}
