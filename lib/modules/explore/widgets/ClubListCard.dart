import 'package:flutter/material.dart';



// ignore: must_be_immutable
class ClubListCard extends StatefulWidget {
  ClubListCard({Key key, this.data})
      : super(key: key);
  var data;
  @override
  _ClubListCardState createState() => _ClubListCardState();
}

class _ClubListCardState extends State<ClubListCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
        ),
        title: Text(widget.data['name']),
        subtitle: Text(widget.data['motto']),
      ),
    );
  }
}


