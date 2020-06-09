import 'package:flutter/material.dart';

class NewsClicks extends StatelessWidget {
  const NewsClicks(
      {Key key,
      @required this.clicks,
      @required this.size,
      @required this.color})
      : super(key: key);

  final int clicks;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.remove_red_eye,
          size: size,
          color: color.withOpacity(1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            clicks.toString(),
            style: TextStyle(
              color: color,
              fontSize: size,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
