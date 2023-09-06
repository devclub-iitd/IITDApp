import 'package:flutter/material.dart';
import 'package:iitd_app/features/drawer.dart';
import 'package:iitd_app/features/hangouts/components/hangoutcomponents.dart';
import 'package:iitd_app/features/hangouts/data/hangoutsdata.dart';
import 'package:iitd_app/features/hangouts/data/hangoutsdetails.dart';
import 'package:iitd_app/features/hangouts/pages/hangoutdetailspage.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';

class HangoutsPage extends StatelessWidget {
  const HangoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<HangoutCardModel> hangoutsList = hangoutsJSONdata
        .map((hangoutdata) => HangoutCardModel.fromJson(hangoutdata))
        .toList();

    hangoutsList.shuffle();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const BoldText(
          title: "Hangouts",
          size: 24,
          textcolor: AppColors.backgroundColor,
        ),
        backgroundColor: AppColors.primaryColorDark,
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: GridView.builder(
            padding: const EdgeInsets.all(4.0),
            itemCount: hangoutsList.length,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 15,
                childAspectRatio: 0.85),
            itemBuilder: (context, index) {
              HangoutCardModel card = hangoutsList[index];
              return InkWell(
                  onTap: () {
                    HangoutDetailModel? more = getHangoutDetailModelByKey(card.name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HangoutsDetailPage(
                          detail: more!,
                          card: card,
                        ),
                      ),
                    );
                  },
                  child: Hangoutcard(
                    card: card,
                  ));
            }),
      ),
    );
  }
}
