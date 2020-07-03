import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
class NewsDate extends StatelessWidget {
  const NewsDate(
      {Key key,
      @required this.createdAt,
      @required this.size,
      @required this.color})
      : super(key: key);

  final DateTime createdAt;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      timeago.format(createdAt.subtract(Duration(minutes: 330))),
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
