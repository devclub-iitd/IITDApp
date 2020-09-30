import 'package:flutter/material.dart';

class NewsTitle extends StatelessWidget {
  const NewsTitle(
      {Key key, @required this.title, @required this.size, this.color,this.maxLines})
      : super(key: key);

  final String title;
  final double size;
  final Color color;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines??5,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
