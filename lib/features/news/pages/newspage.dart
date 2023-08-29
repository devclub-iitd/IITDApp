import 'package:flutter/material.dart';
import 'package:iitd_app/features/drawer.dart';
import 'package:iitd_app/features/news/components/newscomponents.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        child: Column(
          children: [
            NewsComponents().carousel(context),
            
          ],
        ),

      ),
    );
  }
}
