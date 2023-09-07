import 'package:flutter/material.dart';
import 'package:iitd_app/features/drawer.dart';
import 'package:iitd_app/features/quicklinks/quicklinkscomponents.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';

class QuickLinks extends StatelessWidget {
  const QuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const BoldText(
          title: "Quick Links",
          size: 24,
          textcolor: AppColors.backgroundColor,
        ),
        backgroundColor: AppColors.primaryColorDark,
      ),
      drawer: buildDrawer(context),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(child: LinksWidget()),
      ),
    );
  }
}
