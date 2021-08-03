import 'package:IITDAPP/modules/explore/data/ClubsData.dart';
import 'package:IITDAPP/modules/explore/widgets/ClubListCard.dart';
import 'package:IITDAPP/modules/explore/widgets/CustomAnimatedListView.dart';
import 'package:flutter/material.dart';

class ClubsListView extends StatefulWidget {
  @override
  _ClubsListViewState createState() => _ClubsListViewState();
}
//typedef CustomCallBack = ClubListCard Function(String value);

class _ClubsListViewState extends State<ClubsListView> {
  // Widget Function() abcd = ClubListCard as Widget Function();

  @override
  Widget build(BuildContext context) {
    var lis = List.filled(clubsList.length, ClubListCard(), growable: true);
    for (var i = 0; i < clubsList.length; i++) {
      var temp = clubsList[i];
      temp['idx'] = i;
      lis[i] = ClubListCard(
        data: temp,
      );
    }
    return CustomAnimatedListView(list: lis);
  }
}
