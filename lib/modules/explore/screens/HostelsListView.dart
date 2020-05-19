import 'package:IITDAPP/modules/explore/data/HostelsData.dart';
import 'package:IITDAPP/modules/explore/widgets/CustomAnimatedListView.dart';
import 'package:IITDAPP/modules/explore/widgets/HostelListCard.dart';
import 'package:flutter/material.dart';

class HostelsListView extends StatefulWidget {
  @override
  _HostelsListViewState createState() => _HostelsListViewState();
}

class _HostelsListViewState extends State<HostelsListView> {

  @override
  Widget build(BuildContext context) {
    var lis = List(hostelsList.length);
    for (var i=0;i<hostelsList.length;i++){
      var temp = hostelsList[i];
      temp['idx'] = i;
      lis[i] = HostelListCard(data: temp,);
    }

    return CustomAnimatedListView(
        list: lis
    );
  }
}
