import 'package:flutter/material.dart';

class NewsTitle extends StatelessWidget {
  const NewsTitle(
      {Key key, @required this.title, @required this.size, this.color})
      : super(key: key);

  final String title;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 3,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
