import 'package:flutter/material.dart';
import 'package:iitd_app/dummydata.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsComponents {
  final PageController controller = PageController();
  Widget carousel(BuildContext context) {
    return Container(
      height: 150,
      child: Stack(
        children: [
          PageView.builder(
              controller: controller,
              itemCount: newsList().length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(newsList()[i].image),
                          fit: BoxFit.fill)),
                );
              }),
          Positioned(
              top: 100,
              left: (MediaQuery.of(context).size.width - 100) / 2,
              child: SmoothPageIndicator(
                onDotClicked: (page) {
                  controller.jumpToPage(page);
                },
                controller: controller,
                count: newsList().length,
                effect: JumpingDotEffect(),
              ))
        ],
      ),
    );
  }

  Widget listnews(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: newsList().length,
      itemBuilder: (context, i) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Container(
          height: 160,
          width: MediaQuery.of(context).size.width-40,
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.all(Radius.circular(15),
            
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              Container(
                width: MediaQuery.of(context).size.width-40,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                  image:DecorationImage(image: NetworkImage(newsList()[i].image),fit: BoxFit.cover),),),
                 Text(newsList()[i].title) 
            ],
          ),
        ),
      );
    });
  }
}
