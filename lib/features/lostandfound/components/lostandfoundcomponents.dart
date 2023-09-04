import 'package:flutter/material.dart';
import 'package:iitd_app/models/lostandfoundmodel.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/globalwidgets.dart';
import 'package:intl/intl.dart';

class LostFoundComponents {
  Widget lostCard(LostandFoundModel lostandFoundModel, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 14),
      width: (MediaQuery.of(context).size.width - 50) / 2,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  margin: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage("assets/images/devCLogo.png"),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(lostandFoundModel.name),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    NormalText400(
                        title: lostandFoundModel.place,
                        size: 14,
                        textcolor: AppColors.textColor),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.timer,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    NormalText400(
                        title:
                            "${DateFormat('d MMM').format(lostandFoundModel.createdAt)} ${DateFormat('h:mm a').format(lostandFoundModel.createdAt)}",
                        size: 14,
                        textcolor: AppColors.textColor),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.history,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    NormalText400(
                        title:
                            lostandFoundModel.status.toString().split(".")[1],
                        size: 14,
                        textcolor: AppColors.textColor),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 4,
              right: 8,
              child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: AppColors.secondaryColor,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: const BoldText(
                        title: "Claim",
                        size: 14,
                        textcolor: AppColors.backgroundColor),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
