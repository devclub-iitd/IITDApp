import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iitd_app/features/hangouts/data/hangoutsdata.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';

class Hangoutcard extends StatelessWidget {
  const Hangoutcard({super.key, required this.card});

  final HangoutCardModel card;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(4.0),
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(card.image), fit: BoxFit.cover),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
              Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      BoldText(
                          title: card.rating.toString(),
                          size: 16,
                          textcolor: AppColors.backgroundColor),
                    ],
                  )),
              Positioned(
                  bottom: 8.0,
                  left: 8.0,
                  child: NormalText400(
                    title: card.note,
                    size: 12,
                    textcolor: AppColors.backgroundColor,
                  ))
            ],
          ),
          BoldText(
            title: card.name,
            size: 24,
            textcolor: AppColors.primaryColorDark,
          ),
          NormalText400(
              title: card.comment, size: 14, textcolor: AppColors.textColor),
        ],
      ),
    );
  }
}
