import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iitd_app/features/hangouts/components/hangoutcomponents.dart';
import 'package:iitd_app/features/hangouts/data/hangoutsdata.dart';
import 'package:iitd_app/features/hangouts/data/hangoutsdetails.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';
import 'package:url_launcher/url_launcher.dart';

class HangoutsDetailPage extends StatelessWidget {
  const HangoutsDetailPage(
      {super.key, required this.card, required this.detail});

  final HangoutCardModel card;
  final HangoutDetailModel detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: BoldText(
          title: card.name,
          size: 24,
          textcolor: AppColors.backgroundColor,
        ),
        backgroundColor: AppColors.primaryColorDark,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hangoutcard(card: card),
              const SizedBox(
                height: 8,
              ),
              Text(
                detail.about,
                maxLines: 4,
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoldText(
                      title: detail.phone,
                      size: 20,
                      textcolor: AppColors.textColor),
                  InkWell(
                    onTap: () async {
                      await launchUrl(Uri.parse(detail.loc));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NormalText400(
                            title: 'View on Map',
                            size: 14,
                            textcolor: AppColors.textColor),
                        SizedBox(
                          width: 4.0,
                        ),
                        FaIcon(
                          FontAwesomeIcons.locationArrow,
                          size: 20,
                          color: AppColors.primaryColorDark,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
