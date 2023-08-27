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
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.65),
                  itemCount: lostandfoundlist().length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    LostandFoundModel lostandFoundModel =
                        lostandfoundlist()[i];
                    return LostFoundComponents()
                        .lostCard(lostandFoundModel, context);
                  }),
            )
          ],
        ),
      )),
    );
  }
}
