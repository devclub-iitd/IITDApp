import 'package:flutter/material.dart';

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
      '${createdAt.year}-' +
          createdAt.month.toString().padLeft(2, '0') +
          '-' +
          createdAt.day.toString().padLeft(2, '0') +
          ' | ' +
          createdAt.hour.toString().padLeft(2, '0') +
          ':' +
          createdAt.minute.toString().padLeft(2, '0'),
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
