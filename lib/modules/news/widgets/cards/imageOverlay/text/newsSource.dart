import 'package:flutter/material.dart';

class NewsSource extends StatelessWidget {
  const NewsSource(
      {Key key, this.sourceName, @required this.size, @required this.color})
      : super(key: key);

  final String sourceName;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      sourceName,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
