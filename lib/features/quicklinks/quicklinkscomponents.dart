import 'package:flutter/material.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'quicklinkdata.dart';

class LinksWidget extends StatelessWidget {
  const LinksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: linksData.keys.map((key) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BoldText(
                  title: key, size: 18, textcolor: AppColors.primaryColorDark),
            ),
            Wrap(
              children: linksData[key]!.map((link) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ActionChip(
                    padding: const EdgeInsets.all(4.0),
                    backgroundColor: AppColors.primaryColorLight.withOpacity(0.2),
                    label: NormalText400(
                        title: link.name,
                        size: 14,
                        textcolor: AppColors.secondaryColor),
                    onPressed: () async {
                      await launchUrl(Uri.parse(link.url));
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        );
      }).toList(),
    );
  }
}
