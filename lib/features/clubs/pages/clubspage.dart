import 'package:flutter/material.dart';
import 'package:iitd_app/features/clubs/components/clubcomponents.dart';
import 'package:iitd_app/features/clubs/data/clubsdata.dart';
import 'package:iitd_app/features/clubs/data/clubsdetaildata.dart';
import 'package:iitd_app/features/clubs/pages/clubdetailspage.dart';

import '../../../utils/colors.dart';
import '../../../utils/globalwidgets.dart';
import '../../drawer.dart';

class ClubsPage extends StatelessWidget {
  const ClubsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ClubCardModel> clubsList = clubsListJSONdata
        .map((clubData) => ClubCardModel.fromJson(clubData))
        .toList();

    clubsList.shuffle();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const BoldText(
          title: "Clubs",
          size: 24,
          textcolor: AppColors.backgroundColor,
        ),
        backgroundColor: AppColors.primaryColorDark,
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 15,
                childAspectRatio: 0.85),
            padding: const EdgeInsets.all(4.0),
            itemCount: clubsList.length,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              ClubCardModel card = clubsList[index];
              return InkWell(
                  onTap: () {
                    ClubDetailModel? more = getClubDetailModelByKey(card.name!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClubDetailsPage(
                          detail: more!,
                          card: card,
                        ),
                      ),
                    );
                  },
                  child: ClubCard(
                    card: card,
                  ));
            }),
      ),
    );
  }
}
