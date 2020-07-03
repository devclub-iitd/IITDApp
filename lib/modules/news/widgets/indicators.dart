import 'package:IITDAPP/modules/news/data/carouselIndex.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Indicators extends StatelessWidget {
  const Indicators({
    Key key,
    @required this.length,
  }) : super(key: key);

  final int length;

  @override
  Widget build(BuildContext context) {
    var _current = Provider.of<CarouselIndex>(context).getCurrent();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == index
                ? Color.fromRGBO(150, 150, 150, 0.9)
                : Color.fromRGBO(150, 150, 150, 0.4),
          ),
        );
      }).toList(),
    );
  }
}
