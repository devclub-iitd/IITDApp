import 'package:IITDAPP/modules/explore/data/HangoutListData.dart';
import 'package:IITDAPP/modules/explore/widgets/AboutScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:IITDAPP/utility/UrlHandler.dart';

// ignore: must_be_immutable
class HangoutListCard extends StatelessWidget {
  HangoutListCard({Key key, this.data}) : super(key: key);
  var data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutScreen(name: data['name'],obj: hangoutsDetails,hideFabs: true,)),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 90,
              width: 110,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(data['image']))),
              ),
            ),
            Expanded(
              child: Container(
                height: 90,
//              color: Colors.blue,
                padding: EdgeInsets.only(left: 8, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          data['name'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        RatingBox(rating: data['rating'])
                      ],
                    ),
                    Text(
                      data['note'],
                      style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey,height: 1.2),
                    ),
                    Expanded(
                      child: Container(
//                      color: Colors.red,
//                      child: Align(
//                        alignment: Alignment.bottomLeft,
//                        child: Text(data['comment'],style: TextStyle(color: Colors.lightBlue),),
//                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                        children: <Widget>[
                      Text(data['comment'],style: TextStyle(color: Colors.lightBlue)),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              UrlHandler.launchInBrowser(hangoutsDetails[data['name']]['loc']);
                            },
                            icon: Icon(Icons.location_on),
                          ),
                        ],
                      ),
                      ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingBox extends StatelessWidget {
  RatingBox({Key key, this.rating}) : super(key: key);
  final double rating;

  @override
  Widget build(BuildContext context) {
    var colors = [Colors.red,Colors.deepOrangeAccent,Colors.lightGreen,Colors.green,Colors.green];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 6),
      decoration: BoxDecoration(
          color: colors[rating.toInt()-1],
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Center(
          child: Text(
        rating.toString(),
        style: TextStyle(fontSize: 10, color: Colors.white),
      )),
    );
  }
}
