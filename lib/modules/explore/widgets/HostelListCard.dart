import 'package:IITDAPP/modules/explore/data/HostelsData.dart';
import 'package:IITDAPP/modules/explore/widgets/AboutScreen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HostelListCard extends StatelessWidget {
  HostelListCard({Key key, this.data}) : super(key: key);
  var data;

  @override
  Widget build(BuildContext context) {
    // var cardColors = [Colors.red, Colors.green, Colors.blue];
    return Container(
     // color: cardColors[data['idx'] % 3],
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(15.0),
//      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutScreen(name: data['name'],obj: hostelDetails,)),
          );
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
                height: 80,
                width: 100,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      image: DecorationImage(
                          fit: BoxFit.fill, image: AssetImage(data['image']))),
//                  child: Image.asset(data['image']),
                ),
              ),
              Expanded(
                child: Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(horizontal: 15),
//                color: Colors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(data['name'] + ' Hostel',
                          style: TextStyle(fontSize: 21)),
                      Text(
                        data['tagline'],
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 18),
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
