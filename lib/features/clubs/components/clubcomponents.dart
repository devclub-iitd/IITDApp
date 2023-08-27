import 'package:flutter/material.dart';
import 'package:iitd_app/features/clubs/data/clubsdata.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';

class ClubCard extends StatelessWidget {
  const ClubCard({super.key, required this.card});
  final ClubCardModel card;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(4.0),
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(card.image!), fit: BoxFit.cover),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
          BoldText(
            title: card.name!,
            size: 24,
            textcolor: AppColors.primaryColorDark,
          ),
          NormalText400(
              title: card.motto!, size: 14, textcolor: AppColors.textColor),
        ],
      ),
    );
  }
}
