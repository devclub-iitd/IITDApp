import 'package:flutter/material.dart';
import 'package:iitd_app/models/lostandfoundmodel.dart';
import 'package:iitd_app/utils/colors.dart';
import 'package:iitd_app/utils/constants.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: lostandFoundModel.imgUrl == "${EndPoints.baseURL}/null"
                  ? Image.asset(
                      'assets/images/default.jpeg',
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      lostandFoundModel.imgUrl!,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
            ),
            BoldText(
                title: lostandFoundModel.name,
                size: 14,
                textcolor: AppColors.primaryColor),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 18,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                NormalText400(
                    title: lostandFoundModel.place,
                    size: 13,
                    textcolor: Colors.grey),
              ],
            ),
            const SizedBox(
              height: 6.0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.timer,
                  color: AppColors.primaryColor,
                  size: 18,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                NormalText400(
                    title:
                        "${DateFormat('d MMM').format(lostandFoundModel.createdAt)} ${DateFormat('h:mm a').format(lostandFoundModel.createdAt)}",
                    size: 13,
                    textcolor: Colors.grey),
              ],
            ),
            const SizedBox(
              height: 6.0,
            ),
            Row(
              children: [
                const Icon(
                  Icons.history,
                  color: AppColors.primaryColor,
                  size: 18,
                ),
                const SizedBox(
                  width: 4.0,
                ),
                NormalText400(
                    title: lostandFoundModel.status.toString().split(".")[1],
                    size: 13,
                    textcolor: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
