import 'package:flutter/material.dart';

class ShimmerTile extends StatelessWidget {
  const ShimmerTile({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        width: width - 16,
        height: (width - 16) * 0.45 * 2 / 3,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            width: (width - 16) * 0.45,
            height: (width - 16) * 0.45 * 2 / 3,
          ),
          Container(
              height: (width - 16) * 0.45 * 2 / 3,
              width: (width - 16) * 0.55,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 20,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  Container(
                    height: 20,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}
