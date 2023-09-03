import 'package:flutter/material.dart';
import 'package:iitd_app/dummydata.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsComponents {
  final PageController controller = PageController();
  Widget carousel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height * 0.275,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
              controller: controller,
              itemCount: newsList().length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: NetworkImage(newsList()[i].image),
                          fit: BoxFit.fill)),
                );
              }),
          Positioned(
            bottom: 8,
            child: SmoothPageIndicator(
              onDotClicked: (page) {
                controller.jumpToPage(page);
              },
              controller: controller,
              count: newsList().length,
              effect: const JumpingDotEffect(),
            ),
          )
        ],
      ),
    );
  }

  Widget listnews(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: newsList().length,
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
                      newsList()[i].image,
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
                        BoldText(
                            title: newsList()[i].title,
                            size: 16,
                            textcolor: AppColors.primaryColor),
                        Text(
                          newsList()[i].details,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
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
