import 'package:flutter/material.dart';

class NewsAuthor extends StatelessWidget {
  const NewsAuthor({
    Key key,
    @required this.author,
    @required this.size,
    @required this.color,
  }) : super(key: key);

  final String author;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.edit,
          size: size,
          color: color.withOpacity(1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            author,
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
