
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
    return CustomAnimatedListView(
      Item: ClubListCard(),
      list: clubsList
    );
  }
}
