import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HostelListCard extends StatelessWidget {
  HostelListCard({Key key, this.data}) : super(key: key);
  var data;

  @override
  Widget build(BuildContext context) {
    var cardColors = [Colors.red,Colors.green,Colors.blue];
    return Card(
      color: cardColors[data['idx']%3],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          print("Hoew are ' u");
        },
        splashColor: Colors.white.withAlpha(100),
        splashFactory: InkSplash.splashFactory,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//      color: Colors.redAccent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset(data['image']),
              ),
              Expanded(
                child: Container(
                  height: 150,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 24),
//                color: Colors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(data['name'],
                          style: TextStyle(color: Colors.white, fontSize: 27)),
                      Text(
                        data['tagline'],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
