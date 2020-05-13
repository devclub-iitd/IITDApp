import 'package:IITDAPP/modules/explore/widgets/ClubListCard.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomAnimatedListView extends StatefulWidget {
  var list;
  var Item;
  CustomAnimatedListView({Key key, this.list, this.Item}) : super(key: key);
  @override
  _CustomAnimatedListViewState createState() => _CustomAnimatedListViewState();
}

class _CustomAnimatedListViewState extends State<CustomAnimatedListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          var temp = widget.list[index];
          temp['idx'] = index;
          widget.Item.data = temp;
          return widget.Item;
        });
  }
}
