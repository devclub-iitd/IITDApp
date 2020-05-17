
import 'package:IITDAPP/modules/explore/data/HangoutListData.dart';
import 'package:IITDAPP/modules/explore/widgets/CustomAnimatedListView.dart';
import 'package:IITDAPP/modules/explore/widgets/HangoutListCard.dart';
import 'package:flutter/material.dart';

class HangoutsListView extends StatefulWidget {
  @override
  _HangoutsListViewState createState() => _HangoutsListViewState();
}
//typedef CustomCallBack = ClubListCard Function(String value);

class _HangoutsListViewState extends State<HangoutsListView> {

  // Widget Function() abcd = ClubListCard as Widget Function();


  @override
  Widget build(BuildContext context) {
    var lis = List(hangoutsList.length);
    for (var i=0;i<hangoutsList.length;i++){
      var temp = hangoutsList[i];
      temp['idx'] = i;
      lis[i] = HangoutListCard(data: temp,);
    }
    return CustomAnimatedListView(
        list: lis
    );
  }
}
