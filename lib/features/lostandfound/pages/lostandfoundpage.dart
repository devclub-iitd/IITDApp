import 'package:flutter/material.dart';
import 'package:iitd_app/dummydata.dart';
import 'package:iitd_app/features/drawer.dart';
import 'package:iitd_app/features/lostandfound/components/lostandfoundcomponents.dart';
import 'package:iitd_app/models/lostandfoundmodel.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';

class LostAndFoundPage extends StatefulWidget {
  const LostAndFoundPage({super.key});

  @override
  State<LostAndFoundPage> createState() => _LostAndFoundPageState();
}

class _LostAndFoundPageState extends State<LostAndFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const BoldText(
          title: "Lost and Found",
          size: 24,
          textcolor: AppColors.backgroundColor,
        ),
        backgroundColor: AppColors.primaryColorDark,
      ),
      drawer: buildDrawer(context),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: lostandfoundlist().length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  LostandFoundModel lostandFoundModel = lostandfoundlist()[i];
                  return LostFoundComponents()
                      .lostCard(lostandFoundModel, context);
                })
          ],
        ),
      )),
    );
  }
}
