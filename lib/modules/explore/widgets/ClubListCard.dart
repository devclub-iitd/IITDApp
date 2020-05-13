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
        leading: ClipOval(
          child: Image.asset('assets/images/devCLogo.png'),
        ),
//        leading: Container(
//            width: 300,
//            height: 300,
//            decoration: BoxDecoration(
//                shape: BoxShape.circle,
//                image: DecorationImage(
//                    fit: BoxFit.cover,
//                    image: NetworkImage(
//                        'https://www.woolha.com/media/2019/06/buneary.jpg')
//                )
//            )
//        ),
        title: Text(widget.data['name'],style: TextStyle(fontSize: 20)),
        subtitle: Text(widget.data['motto'],style: TextStyle(fontSize: 16)),
      ),
    );
  }
}


