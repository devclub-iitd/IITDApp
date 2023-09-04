import 'package:flutter/material.dart';
import 'package:iitd_app/models/newsmodel.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsListView extends StatelessWidget {
  const NewsListView({super.key, required this.list});

  final List<NewsModel> list;

  @override
  Widget build(BuildContext context) {
    return listnews(context, list);
  }

  Widget listnews(BuildContext context, List<NewsModel> list) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, i) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primaryColor,
                      blurRadius: 5,
                      offset: Offset(2, 2))
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      list[i].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NormalText200(
                            title:
                                "${DateFormat('d MMM').format(list[i].createdAt)} ${DateFormat('h:mm a').format(list[i].createdAt)}",
                            size: 12,
                            textcolor: Colors.grey),
                        BoldText(
                            title: list[i].title,
                            size: 16,
                            textcolor: AppColors.primaryColor),
                        Text(
                          list[i].details,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NormalText200(
                                title: "by ${list[i].author}",
                                size: 12,
                                textcolor: Colors.grey),
                            NormalText200(
                                title: "Source: ${list[i].sourcename}",
                                size: 12,
                                textcolor: Colors.grey)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class NewsComponent extends StatelessWidget {
  const NewsComponent({super.key, required this.newsList});

  final List<NewsModel> newsList;

  @override
  Widget build(BuildContext context) {
    return carousel(context);
  }

  Widget carousel(BuildContext context) {
    final PageController controller = PageController();
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height * 0.275,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
              controller: controller,
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return Stack(
                  children: [
                    Image.network(
                      newsList[i].image,
                      height: MediaQuery.of(context).size.height * 0.275,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        top: 8,
                        left: 8,
                        child: Text(
                          newsList[i].title,
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 26,
                            color: AppColors.textColor,
                          ),
                        ))
                  ],
                );
              }),
          Positioned(
            bottom: 8,
            child: SmoothPageIndicator(
              onDotClicked: (page) {
                controller.jumpToPage(page);
              },
              controller: controller,
              count: 6,
              effect: const JumpingDotEffect(),
            ),
          )
        ],
      ),
    );
  }
}
