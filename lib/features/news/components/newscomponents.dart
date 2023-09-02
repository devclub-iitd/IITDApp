import 'package:flutter/material.dart';
import 'package:iitd_app/dummydata.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsComponents {
  final PageController controller = PageController();
  Widget carousel(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: 160,
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
              top: 120,
              left: (MediaQuery.of(context).size.width - 100) / 2,
              child: Theme(
                data: ThemeData(),
                child: SmoothPageIndicator(
                  onDotClicked: (page) {
                    controller.jumpToPage(page);
                  },
                  controller: controller,
                  count: newsList().length,
                  effect: const JumpingDotEffect(),
                ),
              ))
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
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal:5.0,vertical: 10),
        child: Container(
          height: 170,
          
          width: MediaQuery.of(context).size.width-40,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: AppColors.primaryColor,blurRadius: 5,offset: Offset(2, 2))],
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
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                  image:DecorationImage(image: NetworkImage(newsList()[i].image),fit: BoxFit.cover),),),
                 Padding(
                   padding: const EdgeInsets.only(left:8.0),
                   child: Text(newsList()[i].title,style: TextStyle(fontSize: 18),),
                 ) 
            ],
          ),
        ),
      );
    });
  }
}
