import 'package:flutter/material.dart';
import 'package:iitd_app/models/lostandfoundmodel.dart';
import 'package:intl/intl.dart';

class LostFoundComponents {
  Widget lostCard(LostandFoundModel lostandFoundModel, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14),
      width: (MediaQuery.of(context).size.width - 50) / 2,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              margin: EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage("assets/images/devCLogo.png"),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(lostandFoundModel.title),
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                Text(lostandFoundModel.wherefound),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.timer,
                  color: Colors.blue,
                ),
                Text(
                    "${DateFormat('d MMM').format(lostandFoundModel.timestamp)} ${DateFormat('h:mm a').format(lostandFoundModel.timestamp)}"),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.history,
                  color: Colors.blue,
                ),
                Text(lostandFoundModel.status.toString().split(".")[1]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
