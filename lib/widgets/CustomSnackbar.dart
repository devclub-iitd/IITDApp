import 'package:flutter/material.dart';

// ignore: always_declare_return_types
class CustomSnackBarContent extends StatelessWidget {
  CustomSnackBarContent({this.text,this.leading,this.trailing,this.onClick});
  final text;
  final onClick;
  final trailing;
  final leading;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onClick,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            leading??Container(width: 8,),
            Text(text),
            Spacer(),
            trailing??Container(),
          ],
        ),
      ),
    );
  }
}