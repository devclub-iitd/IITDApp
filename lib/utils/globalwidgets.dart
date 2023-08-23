import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  const BoldText({
    super.key,
    required this.title,
    required this.size,
    required this.textcolor,
  });

  final String title;
  final double size;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: textcolor, fontSize: size, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
    );
  }
}

class NormalText500 extends StatelessWidget {
  const NormalText500({
    super.key,
    required this.title,
    required this.size,
    required this.textcolor,
  });

  final String title;
  final double size;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w500, fontSize: size, color: textcolor, overflow: TextOverflow.ellipsis),
    );
  }
}

class NormalText400 extends StatelessWidget {
  const NormalText400({
    super.key,
    required this.title,
    required this.size,
    required this.textcolor,
  });

  final String title;
  final double size;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: size, color: textcolor, overflow: TextOverflow.ellipsis),
    );
  }
}
