import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iitd_app/features/clubs/components/clubcomponents.dart';
import 'package:iitd_app/features/clubs/data/clubsdata.dart';
import 'package:iitd_app/features/clubs/data/clubsdetaildata.dart';
import 'package:iitd_app/features/events/components/eventscomponents.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/globalwidgets.dart';

class ClubDetailsPage extends StatelessWidget {
  const ClubDetailsPage({super.key, required this.detail, required this.card});
  final ClubDetailModel detail;
  final ClubCardModel card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: BoldText(
          title: card.name!,
          size: 24,
          textcolor: AppColors.backgroundColor,
        ),
        backgroundColor: AppColors.primaryColorDark,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClubCard(
                card: card,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                detail.about!,
                maxLines: 4,
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(
                height: 8.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        await launchUrl(Uri.parse(detail.insta!));
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.instagram,
                        size: 32,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    InkWell(
                      onTap: () async {
                        await launchUrl(Uri.parse(detail.linkedin!));
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.linkedin,
                        size: 32,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    InkWell(
                      onTap: () async {
                        await launchUrl(Uri.parse(detail.facebook!));
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.facebook,
                        size: 32,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    InkWell(
                      onTap: () async {
                        await launchUrl(Uri.parse(detail.web!));
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.chrome,
                        size: 32,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              EventsList(clubID: card.id!, tabSelected: -1)
            ],
          ),
        ),
      ),
    );
  }
}
