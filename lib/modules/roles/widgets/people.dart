import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PersonCard extends StatefulWidget {
  final String name;
  PersonCard(this.name);
  @override
  _PersonCardState createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(widget.name, style: TextStyle(color: Colors.black)),
          Spacer(),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                      content: Container(
                        height: 20,
                        width: 20,
                      ),
                      title: Text('Hello')));
            },
            icon: Icon(CupertinoIcons.minus_circled),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          )
        ],
      ),
    );
  }
}
